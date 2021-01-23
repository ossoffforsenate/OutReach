# frozen_string_literal: true

class ReachClient
  PERSON_ID_TYPE = "State File ID"

  def initialize(base_url: "https://api.reach.vote", username:, password:)
    @base_url = base_url
    @username = username
    @password = password
  end

  def record_response(person_id, user_id, question_id, choice_id)
    payload = {
      responses: [
        person_id: person_id,
        person_id_type: PERSON_ID_TYPE,
        question_id: question_id,
        user_id: user_id,
        response_datetime: response_datetime,
        choice_ids: [choice_id]
      ]
    }

    token = get_token

    if token
      uri = URI.parse("#{base_url}/api/v1/responses")

      headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{token}",
        'Accept': 'application/json'
      }

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = payload.to_json
      response = http.request(request)

      unless [200, 201].include? response.code.to_i
        Rails.logger.error("Unable to send reach update with payload: " + payload.to_json + "\nResponse: " + response.body)
      end

      return true
    end

    false
  rescue => e
    Rails.logger.error("Unable to send reach update with payload: " + payload.to_json + "\n" + e.to_s)
  end

  private

  attr_reader :base_url, :username, :password

  def response_datetime
    DateTime.now.in_time_zone('Eastern Time (US & Canada)').strftime("%FT%T.%6N")
  end

  def get_token
    uri = URI.parse("#{base_url}/oauth/token")
    response = Net::HTTP.post_form(uri, 'username' => username, 'password' => password)
    return JSON.parse(response.body)["access_token"] if response.code.to_i == 200
    Rails.logger.error("Unable to get access token from reach. Response: " + response.body)
  rescue => e
    Rails.logger.error("Unable to get access token from reach.\n" + e.to_s)
  end
end
