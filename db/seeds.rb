image = Image.last
user = User.first

5.times do
  Like.create(image_id: image.id, user_id: user.id)
end

5.times do |i|
  Comment.create(commenter: "User #{i}", body: "Comment #{i}", image_id: image.id, user_id: user.id)
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Action.create!(action_type: "navigation")
Action.create!(action_type: "user_sign_in")
Action.create!(action_type: "user_sign_out")
Action.create!(action_type: "likes")
Action.create!(action_type: "comments")