class Note < ApplicationRecord
  belongs_to :patient
  has_many :practice_words, dependent: :destroy

  accepts_nested_attributes_for :practice_words
end
