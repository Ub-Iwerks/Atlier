FactoryBot.define do
  factory :work_create_form do
    after(:build) do |work_create_form|
      work_create_form.image.attach(io: File.open('spec/fixture/files/test.jpeg'), filename: 'test.jpeg')
      work_create_form.illustration_photo.attach(io: File.open('spec/fixture/files/test.jpeg'), filename: 'test.jpeg')
    end

    title { |n| "TITLE#{n}" }
    concept { |n| "CONCEPT#{n}" }
    description { |n| "DESCRIPTION#{n}" }
    illustration_name { |n| "illustration_name#{n}" }
    illustration_description { |n| "illustration_description#{n}" }
  end
end
