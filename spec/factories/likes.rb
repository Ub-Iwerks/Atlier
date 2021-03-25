FactoryBot.define do
  factory :like do
    association :user
    association :work
  end
end
