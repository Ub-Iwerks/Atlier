users = User.order(:created_at).take(11)
3.times.with_index do |i|
  title = Faker::Movie.title
  concept = Faker::Lorem.sentence(word_count: 10)
  description = Faker::Lorem.sentence(word_count: 10)
  category = Category.find_by(name: "教育施設")
  work = users[0].works.build(title: title, concept: concept, description: description, category_id: category.id)
  work.image.attach(io: File.open("app/assets/images/works/#{i}-0.png"), filename: "#{i}-0.png", content_type: "image/png")
  work.save
  5.times.with_index do |v|
    illustration = work.illustrations.build
    illustration.photo.attach(io: File.open("app/assets/images/works/#{i}-#{v + 1}.png"), filename: "#{i}-#{v + 1}.png", content_type: "image/png")
    illustration.save
  end
end