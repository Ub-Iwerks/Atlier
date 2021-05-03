users = User.order(:created_at).take(11)
categories = Category.where(ancestry: 1)

2.times do
  users.each do |user|
    title = Faker::Movie.title
    concept = Faker::Lorem.sentence(word_count: 10)
    description = Faker::Lorem.sentence(word_count: 10)
    category = categories.sample
    work = user.works.build(
      title: title,
      concept: concept,
      description: description,
      category_id: category.id
    )
    work.image.attach(io: File.open("app/assets/images/sample.png"), filename: 'sample.png', content_type: "image/png")
    work.save
  end
end

3.times.with_index do |i|
  work = users[0].works.build(
		title: Settings.sample_works["work#{i}_title"],
		concept: Settings.sample_works["work#{i}_concept"],
		description: Settings.sample_works["work#{i}_description"],
		category_id: categories.sample.id
	)
  work.image.attach(io: File.open("app/assets/images/works/#{i}-0.png"), filename: "#{i}-0.png", content_type: "image/png")
  work.save
  5.times.with_index do |v|
    illustration = work.illustrations.build(
			name: Settings.sample_works["work#{i}_name#{v + 1}"],
			description: Settings.sample_works["work#{i}_comment#{v + 1}"]
		)
    illustration.photo.attach(io: File.open("app/assets/images/works/#{i}-#{v + 1}.png"), filename: "#{i}-#{v + 1}.png", content_type: "image/png")
    illustration.save
  end
end

second_users = users[1..6]
second_users.each.with_index(3) do |user, i|
  work = user.works.build(
		title: Settings.sample_works["work#{i}_title"],
		concept: Settings.sample_works["work#{i}_concept"],
		description: Settings.sample_works["work#{i}_description"],
		category_id: categories.sample.id
	)
  work.image.attach(io: File.open("app/assets/images/works/#{i}-0.png"), filename: "#{i}-0.png", content_type: "image/png")
  work.save
  5.times.with_index do |v|
    illustration = work.illustrations.build(
			name: Settings.sample_works["work#{i}_name#{v + 1}"],
			description: Settings.sample_works["work#{i}_comment#{v + 1}"]
		)
    illustration.photo.attach(io: File.open("app/assets/images/works/#{i}-#{v + 1}.png"), filename: "#{i}-#{v + 1}.png", content_type: "image/png")
    illustration.save
  end
end
