# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Topic.destroy_all
Bookmark.destroy_all
Like.destroy_all


5.times do
  User.create!(
    email: Faker::Internet.safe_email,
    password: 'helloworld',
    confirmed_at: Time.now
  )
end
users = User.all

users.sample.topics.create!(title: 'General')

15.times do
  user = users.sample
  user.topics.create!(
    title: Faker::Book.title
  )
end
topics = Topic.all

100.times do
  topic_to_use = topics.sample
  domain = Faker::Internet.domain_name
  topic_to_use.bookmarks.create!(url: domain, user: users.sample, name: domain)
end
bookmarks = Bookmark.all

# Admin User
User.create!(
  email: "admin@blocmark.com",
  password: "helloworld",
  confirmed_at: Time.now,
  role: 1
)

10.times do
  user = users.find_by_email('admin@blocmark.com')
  Like.create!(bookmark_id: bookmarks.sample.id, user_id: user.id)
end

# Normal User 1
User.create!(
  email: "test@blocmark.com",
  password: "helloworld",
  confirmed_at: Time.now
)

# Normal User 2
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
