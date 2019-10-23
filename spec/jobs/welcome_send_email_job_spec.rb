# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeSendEmail do
  describe "#perform" do
    it "matches with enqueued job" do
      expect { WelcomeSendEmail.perform_later }.to have_enqueued_job(WelcomeSendEmail)
      expect { WelcomeSendEmail.perform_later(['bob@gmail.com', 'bob']) }.to have_enqueued_job(WelcomeSendEmail).with(['bob@gmail.com', 'bob'])
      expect { WelcomeSendEmail.perform_later }.to have_enqueued_job.on_queue('default')
    end
    it "sends welcome letter" do
      user = double('user', email: 'bob@gmail.com', username: 'bob')
      allow(User).to receive(:find).and_return(user)
      allow(UserMailer).to receive_message_chain(:welcome_send, :deliver)
      WelcomeSendEmail.perform_later([user.email, user.username])
    end
    it "enqueues sending the welcome letter" do
      allow(WelcomeSendEmail).to receive(:perform_later)
      user = create(:user)
      user.welcome_send
      expect(WelcomeSendEmail).to have_received(:perform_later)
    end
  end
end
