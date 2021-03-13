FactoryBot.define do
  factory :work do
    association :user, factory: :user
    title { "TITLE" }
    concept { |n| "CONCEPT#{n}" }
  end
end
