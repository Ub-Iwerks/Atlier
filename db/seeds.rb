User.create!(
  username:  "Test_User",
  email: "test@example.com",
  description: "My name is Test_User",
  website: "http://example.com/",
  password:              "password",
  password_confirmation: "password",
  confirmed_at: Time.current)

49.times do |n|
username  = "Test#{n+1}"
email = "test#{n+1}@example.com"
description = "My name is #{Faker::Movies::StarWars.character}"
website = "http://example.com/"
password = "password"
User.create!(username:  username,
    email: email,
    description: description,
    website: website,
    password:              password,
    password_confirmation: password,
    confirmed_at: Time.current)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Movie.title
  concept = Faker::Lorem.sentence(word_count: 10)
  description = Faker::Lorem.sentence(word_count: 10)
  users.each do |user|
    work = user.works.build(title: title, concept: concept, description: description)
    work.image.attach(io: File.open("app/assets/images/sample.png"), filename: 'sample.png', content_type: "image/png")
    work.save
  end
end

user = User.first
users = User.all
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }