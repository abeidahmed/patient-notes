class PracticeWord < ApplicationRecord
  belongs_to :note

  validates :name, presence: true
end
