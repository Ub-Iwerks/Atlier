FactoryBot.define do
  factory :comment do
    content { "This is commet" }
    association :work, factory: :work, strategy: :create
    association :user, factory: :user, strategy: :create
  end
end
