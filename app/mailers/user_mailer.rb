class UserMailer < ApplicationMailer

  def welcome_send(user)
    @user = user
    mail to: user.email, subject: "Welcome to my site"
  end

  def subscription_send(subscr)
    @user = User.find(subscr.user_id)
    @category = Category.find(subscr.category_id)
    @subscription = @category.subscriptions.find { |subscription| subscription.user_id == @user.id}
    mail to: @user.email, subject: "Subscription to a category"
  end

  def new_image(image)
    category_id = image.category_id
    @category = Category.find(category_id)
    @image = image
    subscriptions = Subscription.where(category_id: category_id)
    @emails = Array.new
    subscriptions.find_each do |subscription|
      @user = User.find(subscription.user_id)
      @emails << @user.email
    end
    mail to: @emails, subject: "New image add to category"
  end
end
