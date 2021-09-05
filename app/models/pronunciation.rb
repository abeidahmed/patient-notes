class Pronunciation < ApplicationRecord
  belongs_to :practice_word

  enum result: {mispronounced: 0, pronounced: 1}, _default: :mispronounced

  counter_culture :practice_word, column_name: proc { |record| record.pronounced? ? :pronounced_count : :mispronounced_count }
end
