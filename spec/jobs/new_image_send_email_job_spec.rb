require 'rails_helper'

RSpec.describe NewImageSendEmail do
  describe "#perform" do
    it "sends letter about new image" do
      image = double('image', id: 1)
      allow(Image).to receive(:find).and_return(image)
      allow(UserMailer).to receive_message_chain(:new_image, :deliver)
      NewImageSendEmail.perform(image.id)
    end
  end
end
