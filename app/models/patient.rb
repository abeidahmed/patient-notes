class Patient < ApplicationRecord
  has_many :notes, dependent: :destroy

  validates :name, presence: true
end
