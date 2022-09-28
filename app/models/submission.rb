# frozen_string_literal: true

class Submission < ApplicationRecord
  belongs_to :contest
  belongs_to :project
  has_many :submission_votes
end
