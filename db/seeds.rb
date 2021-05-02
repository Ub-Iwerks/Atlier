website = Settings.sample_data[:website]
password = Settings.sample_data[:password]
User.create!(
  username:  "Test_User",
  email: "test@example.com",
  description: "My name is Test_User",
  website: website,
  password:              password,
  password_confirmation: password,
  confirmed_at: Time.current
)

21.times do |n|
  username  = "#{Faker::Movies::StarWars.character}"
  email = "test#{n+1}@example.com"
  description = "My name is #{Faker::Movies::StarWars.character}"
  User.create!(username:  username,
      email: email,
      description: description,
      website: website,
      password:              password,
      password_confirmation: password,
      confirmed_at: Time.current
  )
end

user = User.first
users = User.all
following = users[2..20]
followers = users[3..10]
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

