class Note < ApplicationRecord
  belongs_to :patient
  has_many :practice_words, inverse_of: :note, dependent: :destroy

  accepts_nested_attributes_for :practice_words, reject_if: :word_name_blank?, allow_destroy: true

  private

  def word_name_blank?(attributes)
    attributes["name"].blank?
  end
end
