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

user = User.first
users = User.all
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

architecture, graphic_design, product_design = Category.create(
  [
    {name: "建築"},
    {name: "グラフィックデザイン"},
    {name: "プロダクトデザイン"},
  ],
)
arch_children = architecture.children.create(
  [
    {name: "住宅"},
    {name: "集合住宅"},
    {name: "宿泊施設"},
    {name: "商業施設"},
    {name: "教育施設"},
    {name: "複合施設"},
    {name: "駅"},
    {name: "家具"},
    {name: "店舗"},
    {name: "図書館"},
    {name: "オフィス"},
    {name: "ランドスケープ"},
    {name: "その他"},
  ],
)
graphic_children = graphic_design.children.create(
  [
    {name: "ロゴ"},
    {name: "ポスター"},
    {name: "3Dデザイン"},
    {name: "ピクトグラム"},
    {name: "Webデザイン"},
    {name: "タイポグラフィ"},
    {name: "フォトレタッチ"},
    {name: "その他"},
  ],
)
product_children = product_design.children.create(
  [
    {name: "アパレル"},
    {name: "生活用品"},
    {name: "家電製品"},
    {name: "インテリア"},
    {name: "ユニバーサルデザイン"},
    {name: "乗り物"},
    {name: "その他"},
  ],
)

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Movie.title
  concept = Faker::Lorem.sentence(word_count: 10)
  description = Faker::Lorem.sentence(word_count: 10)
  category = arch_children.sample
  users.each do |user|
    work = user.works.build(title: title, concept: concept, description: description, category_id: category.id)
    work.image.attach(io: File.open("app/assets/images/sample.png"), filename: 'sample.png', content_type: "image/png")
    work.save
  end
end
