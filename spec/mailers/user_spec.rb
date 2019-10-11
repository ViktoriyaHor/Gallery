require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "send welcome email for user" do

    context "send welcome email for user" do
      let(:user) { create :user }
      let(:mail) { UserMailer.welcome_send(user) }

      it "headers for email" do
        expect(mail.subject).to eq("Welcome to my site")
        expect(mail.from).to eq(["from@example.com"])
      end
      it "renders the body" do
        expect(mail.body.encoded).to match("Welcome")
      end
    end
  end
end
