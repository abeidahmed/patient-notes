class PracticeWord < ApplicationRecord
  belongs_to :note
  has_many :pronunciations, inverse_of: :practice_word, dependent: :destroy

  normalize :name, :word_error, :additional_info, with: %i[strip]

  accepts_nested_attributes_for :pronunciations, reject_if: :not_explicit?, allow_destroy: true

  validates :name, presence: true

  def total_pronunciation_attempts
    pronounced_count + mispronounced_count
  end

  def success_percentage
    return if total_pronunciation_attempts.zero?

    (pronounced_count.to_f / total_pronunciation_attempts * 100).ceil
  end

  private

  def not_explicit?(attributes)
    attributes["result"].blank?
  end
end
