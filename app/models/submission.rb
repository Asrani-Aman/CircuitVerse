class Submission < ApplicationRecord
  belongs_to :contest
  belongs_to :project
  has_many :votes
end