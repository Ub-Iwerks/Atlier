# サンプルユーザーを作成する
[*1..5].each do |n|
  User.create!(
    username:  "Sample_User#{n}",
    email: "sample#{n}@example.com",
    password:              Settings.sample_data[:password],
    password_confirmation: Settings.sample_data[:password],
    confirmed_at: Time.current
  )
end
# サンプルの作品を作成する
users = User.all.reverse[0..4].reverse
categories = Category.where(ancestry: 1)
users.each.with_index(1) do |user|
  4.times.with_index do |i|
    title = "Works_title#{i+1}_by_#{user.username}"
    concept = "This is Works_title#{i+1}_by_#{user.username}"
    category = categories.sample
    work = user.works.build(
      title: title,
      concept: concept,
      category_id: category.id
    )
    work.image.attach(io: File.open("app/assets/images/sample.png"), filename: 'sample.png', content_type: "image/png")
    work.save
  end
end
# サンプルの足跡を作成する
main_work = users[0].works.last
users[1..4].each do |user|
  main_work.create_footprint_by(user)
end
user_relation = users[1..4].zip(users[1..4].rotate)
user_relation.each do |users|
  users[1].works.each do |work|
    work.create_footprint_by(users[0])
  end
end
