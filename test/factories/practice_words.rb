FactoryBot.define do
  factory :practice_word do
    sequence(:name) { |n| "word #{n}" }
    word_error { "cook, shake, bird" }
    additional_info { "Any other info" }
    note
  end
end
