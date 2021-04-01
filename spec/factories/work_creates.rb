FactoryBot.define do
  factory :work_create do
    after(:build) do |work_create|
      parent_category = create(:category)
      child_category  = parent_category.children.create(name: "child_category")
      work_create.category_id = child_category.id
    end

    title { |n| "TITLE#{n}" }
    concept { |n| "CONCEPT#{n}" }
    description { |n| "DESCRIPTION#{n}" }
    user_id { 1 }
  end
end
