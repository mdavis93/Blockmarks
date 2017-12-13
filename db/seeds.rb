# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  pw = Faker::Internet.password
  User.create!(
    email: Faker::Internet.safe_email,
    password: pw,
    confirmed_at: Time.now
  )
end
users = User.all

15.times do
  user = users.sample
  user.topics.create!(
    title: Faker::Book.title
  )
end
topics = Topic.all

50.times do
  topic_to_use = topics.sample
  topic_to_use.bookmarks.create!(url: Faker::Internet.domain_name, user: users.sample)
end
bookmarks = Bookmark.all

#Admin User
User.create!(
  email: "admin@blocmark.com",
  password: "helloworld",
  confirmed_at: Time.now,
  role: 1
)

#Normal User 1
User.create!(
  email: "test@blocmark.com",
  password: "helloworld",
  confirmed_at: Time.now
)

#Normal User 2
User.create!(
  email: "other@blocmark.com",
  password: "helloworld",
  confirmed_at: Time.now
)

puts "Seed Complete"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
puts "========"
