class AddSurveyDataToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :survey_data, :json
  end
end
