# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeSendEmail do
  describe "#perform" do
    it "matches with enqueued job" do

      expect {
        WelcomeSendEmail.perform_later
      }.to have_enqueued_job(WelcomeSendEmail)
    end
    it "finds the email by id" do
      ActiveJob::Base.queue_adapter = :test
      expect(User).to receive(:find).with(12)

      WelcomeSendEmail.perform(12)
    end
    it "calls on the UserMailer" do
      ActiveJob::Base.queue_adapter = :test
      user = double('user', email: 'hhhhh@com', username: 'bob')
      allow(User).to receive(:find).and_return(user)
      allow(UserMailer).to receive_message_chain(:welcome_send, :deliver)
      WelcomeSendEmail.perform([user.email, user.username])

      # expect(UserMailer).to have_received(:welcome_send)
    end
  end
end
