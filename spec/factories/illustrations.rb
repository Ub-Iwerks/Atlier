FactoryBot.define do
  factory :illustration do
    after(:build) do |illustration|
      illustration.photo.attach(io: File.open('spec/fixture/files/test.jpeg'), filename: 'test.jpeg')
    end

    association :work, factory: :work, strategy: :create
    name { "This is name" }
    description { "This is describe" }
    position { 1 }
  end
end
