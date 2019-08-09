class UserMailer < ApplicationMailer

  def welcome_send(params)
    @username = params[1]
    mail to: params[0], subject: "Welcome to my site"
  end

  def subscription_send(params)
  # def subscription_send(subscr)
    # @user = User.find(subscr.user_id)
    # @category = Category.find(subscr.category_id)
    # @subscription = @category.subscriptions.find { |subscription| subscription.user_id == @user.id}
    # mail to: @user.email, subject: "Subscription to a category"
    @username = params[1]
    @category = params[2]
    mail to: params[0], subject: "Subscription to a category"
  end

  # def new_image(image)
  #   category_id = image.category_id
  #   @category = Category.find(category_id)
  #   @image = image
  #   subscriptions = Subscription.where(category_id: category_id)
  #   @emails = Array.new
  #   subscriptions.find_each do |subscription|
  #     @user = User.find(subscription.user_id)
  #     @emails << @user.email
  #   end
  #   mail to: @emails, subject: "New image add to category"
  # end
  def new_image(image_id)
    @image = Image.find(image_id)
    category_id = @image.category_id
    @category = Category.find(category_id)
    subscriptions = Subscription.where(category_id: category_id)
    @emails = Array.new
    subscriptions.find_each do |subscription|
      @user = User.find(subscription.user_id)
      @emails << @user.email
    end
    mail to: @emails, subject: "New image add to category"
  end
end
