require 'rails_helper'

RSpec.describe ToSubscribersSendEmail, type: :job do
  # include ActiveJob::TestHelper
  describe "#perform" do
    it "sends letter about subscribe" do
      ActiveJob::Base.queue_adapter = :test
      user = double('user', email: 'bob@gmail.com', username: 'bob')
      category = double('image', slug: 'category')
      allow(UserMailer).to receive_message_chain(:subscription_send, :deliver)
      ToSubscribersSendEmail.perform([user.email, user.username, category.slug])
    end
  end
end
