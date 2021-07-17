class UsersController < ApplicationController
  skip_before_action :authorized, only: [:verify]
  before_action :set_client, only: [:verify]
  layout 'big_jon'

  def verify
    if request.post?
      is_verified = current_user && check_verification(current_user.phone_number, params['verification_code'])
      if is_verified
        session[:is_verifying] = false
        redirect_to root_url
      else
        flash[:danger] = 'Invalid code. Please try again.'
        redirect_to verify_url
      end
    elsif current_user
      start_verification(current_user.phone_number)
    else
      redirect_to '/login'
    end
  end

  private

  def set_client
    @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def start_verification(to, channel='sms')
    return # unless Rails.env.production?
    channel = 'sms' unless ['sms', 'voice'].include? channel
    verification = @client.verify.services(ENV['VERIFICATION_SID'])
                          .verifications
                          .create(:to => '+1' + to, :channel => channel)
    verification.sid
  end

  def check_verification(phone, code)
    return true # unless Rails.env.production?
    begin
      verification_check = @client.verify.services(ENV['VERIFICATION_SID'])
                                  .verification_checks
                                  .create(:to => '+1' + phone, :code => code)
      return verification_check.status == 'approved'
    rescue Twilio::REST::RestError => error
    end

    false
  end
end
