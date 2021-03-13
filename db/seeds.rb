User.create!(
  username:  "Test_User",
  email: "test@example.com",
  password:              "password",
  password_confirmation: "password",
  confirmed_at: Time.current)

# 追加のユーザーをまとめて生成する
49.times do |n|
username  = "Test#{n+1}"
email = "test#{n+1}@example.com"
password = "password"
User.create!(username:  username,
    email: email,
    password:              password,
    password_confirmation: password,
    confirmed_at: Time.current)
end

users = User.order(:created_at).take(6)
50.times do
  concept = Faker::Lorem.sentence(word_count: 10)
  title = Faker::Movie.title
  users.each { |user| user.works.create!(title: title, concept: concept) }
end