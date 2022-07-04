class Relationship < ApplicationRecord
  belongs_to :voter, class_name: 'Voter', foreign_key: 'voter_reach_id'
  belongs_to :user
end
