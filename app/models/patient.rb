class Patient < ApplicationRecord
  has_many :notes, dependent: :destroy

  normalize :name, with: %i[strip]

  validates :name, presence: true
end
