FactoryBot.define do
  factory :work_search do
    keyword { "search" }
    category_id { |n| "#{n}" }
    parent_category_id { |n| "#{n}" }
  end
end
