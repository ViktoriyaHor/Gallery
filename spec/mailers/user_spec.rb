# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  include Rails.application.routes.url_helpers
  describe 'send emails for user' do
    let(:user) { create :user }
    let(:category) { create :category }
    let(:image) { create :image }
    context 'send welcome email for user' do
      let(:mail) { UserMailer.welcome_send(user) }

      it 'headers for email' do
        expect(mail.subject).to eq('Welcome to my site')
        expect(mail.from).to eq(['from@example.com'])
      end
      it 'renders the body' do
        expect(mail.body.encoded).to match('Welcome')
      end
    end

    context 'subscription_send email for user' do
      let(:mail) { UserMailer.subscription_send([user.email, user.username, category.slug]) }

      it 'headers for email' do
        expect { category_url(category) }.not_to raise_error
        expect(mail.subject).to eq('Subscription to a category')
        expect(mail.from).to eq(['from@example.com'])
        expect(mail.body.encoded).to include category_url(category)
      end
      it 'renders the body' do
        expect(mail.body.encoded).to match('You have successfully subscribed to a category')
      end
    end

    context 'new_image email for user' do
      let(:mail) { UserMailer.new_image(image.id) }

      it 'headers for email' do
        expect(mail.subject).to eq('New image add to the category')
        expect(mail.from).to eq(['from@example.com'])
      end
      it 'renders the body' do
        expect(mail.body.encoded).to match('You are subscribed to a category')
      end
    end
  end
end
