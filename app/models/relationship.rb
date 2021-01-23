class Relationship < ApplicationRecord
  belongs_to :voter, class_name: 'Voter', foreign_key: 'voter_sos_id'
  belongs_to :user
end
