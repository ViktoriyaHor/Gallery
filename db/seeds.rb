# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# image = Image.last

5.times do |i|
  Like.create(image_id: 26, user_id: 1)
end

5.times do |i|
  Comment.create(commenter: "User #{i}", body: "Comment #{i}", image_id: 1)
end