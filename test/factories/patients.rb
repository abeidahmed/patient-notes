FactoryBot.define do
  factory :patient do
    sequence(:name) { |n| "John Hemmingway #{n}" }
    avatar { "https://avatar.com" }
  end
end
