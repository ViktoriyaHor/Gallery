# frozen_string_literal: true

# send letter when user subscribes to a category
class ToSubscribersSendEmail < ActiveJob::Base
  @queue = :to_subscribers_email

  def self.perform(params)
    UserMailer.subscription_send(params).deliver
  end
end
