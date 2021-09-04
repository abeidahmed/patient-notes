FactoryBot.define do
  factory :patient do
    sequence(:name) { |n| "John Hemmingway #{n}" }
  end
end
