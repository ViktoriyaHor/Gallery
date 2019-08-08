class Subscription < ApplicationRecord
  belongs_to :category
  belongs_to :user

  after_create :send_email_to_subscribers

  private

  def send_email_to_subscribers
    UserMailer.subscription_send(self).deliver
  end

end
