class PracticeWord < ApplicationRecord
  belongs_to :note
  has_many :pronunciations, inverse_of: :practice_word, dependent: :destroy

  normalize :name, :word_error, :additional_info, with: %i[strip]

  accepts_nested_attributes_for :pronunciations, reject_if: :not_explicit?, allow_destroy: true

  validates :name, presence: true

  private

  def not_explicit?(attributes)
    attributes["result"].blank?
  end
end
