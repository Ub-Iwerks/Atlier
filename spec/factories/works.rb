FactoryBot.define do
  factory :work do
    after(:build) do |work|
      work.image.attach(io: File.open('spec/fixture/files/test400*400.jpeg'), filename: 'test400*400.jpeg')
    end

    association :user, factory: :user, strategy: :create
    title { "TITLE" }
    concept { |n| "CONCEPT#{n}" }
  end
end
