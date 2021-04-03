FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user, strategy: :create
    association :visited, factory: :user, strategy: :create
    association :work, factory: :work, strategy: :create
    association :comment, factory: :comment, strategy: :create
    action { "" }
    checked { false }
  end
end
