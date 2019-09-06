# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

image = Image.last
user = User.first

5.times do
  Like.create(image_id: image.id, user_id: user.id)
end

5.times do |i|
  Comment.create(commenter: "User #{i}", body: "Comment #{i}", image_id: image.id, user_id: user.id)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') #if Rails.env.development?

Action.create!(action_type: "navigation")
Action.create!(action_type: "user sign in")
Action.create!(action_type: "user sign out")
Action.create!(action_type: "likes")
Action.create!(action_type: "comments")