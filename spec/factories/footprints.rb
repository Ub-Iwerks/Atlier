FactoryBot.define do
  factory :footprint do
    counts { 1 }
    association :user, factory: :user, strategy: :create
    association :work, factory: :work, strategy: :create
  end
end
