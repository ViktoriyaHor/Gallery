class Subscription < ApplicationRecord
  belongs_to :category, counter_cache: true
  belongs_to :user

  after_create :send_email_to_subscribers

  private

  def send_email_to_subscribers
    email = User.find(self.user_id).email
    username = User.find(self.user_id).username
    category = Category.find(self.category_id).slug
    Resque.enqueue(ToSubscribersSendEmail, [email, username, category])
    # UserMailer.subscription_send(self).deliver
  end

end
