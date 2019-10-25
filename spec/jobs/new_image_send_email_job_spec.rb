require 'rails_helper'

RSpec.describe NewImageSendEmail do
  include ActiveJob::TestHelper
  describe "#perform" do
    before do
      ResqueSpec.reset!
    end
    it "matches with enqueued job" do
      ActiveJob::Base.queue_adapter = :test

      expect { NewImageSendEmail.perform_later}.to have_enqueued_job(NewImageSendEmail)
      expect { NewImageSendEmail.perform_later(1) }.to have_enqueued_job(NewImageSendEmail).with(1)
      expect { NewImageSendEmail.perform_later }.to have_enqueued_job.on_queue('default')
    end
    it "sends letter about new image" do
      ActiveJob::Base.queue_adapter = :test
      image = double('image', id: 1)
      # allow(Image).to receive(:find).and_return(image)
      allow(UserMailer).to receive_message_chain(:new_image, :deliver)
      NewImageSendEmail.perform(image.id)
    end
  end
end
