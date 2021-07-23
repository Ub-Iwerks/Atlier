users = User.first(5)
users.zip(users.rotate) do |first_user, second_user|
  second_user.works.each do |work|
    Stock.create(user: first_user, work: work)
  end
end