users = User.order(:created_at).take(11)
users.each_with_index do |user, i|
  user.avatar.attach(io: File.open("app/assets/images/avatar/ava#{i}.jpg"), filename: "ava#{i}.jpg", content_type: "image/jpg")
end