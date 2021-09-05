class Pronunciation < ApplicationRecord
  belongs_to :practice_word

  enum result: {mispronounced: 0, pronounced: 1}, _default: :mispronounced
end
