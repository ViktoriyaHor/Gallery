# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeSendEmail, type: :job do
  include ActiveJob::TestHelper
  describe "#perform" do
    it "sends welcome letter" do
      ActiveJob::Base.queue_adapter = :test
      user = double('user', email: 'bob@gmail.com', username: 'bob')
      allow(UserMailer).to receive_message_chain(:welcome_send, :deliver)
      WelcomeSendEmail.perform([user.email, user.username])
    end
  end
end