FactoryBot.define do
  factory :work do
    after(:build) do |work|
      work.image.attach(io: File.open('spec/fixture/files/test.jpeg'), filename: 'test.jpeg')
      parent_category = create(:category)
      child_category  = parent_category.children.create(name: "child_category")
      work.category_id = child_category.id
    end

    after(:create) do |work|
      Footprint.create(user_id: work.user.id, work_id: work.id, counts: 0)
    end

    association :user, factory: :user, strategy: :create
    association :category, factory: :category, strategy: :create
    title { "TITLE" }
    concept { |n| "CONCEPT#{n}" }
  end
end
