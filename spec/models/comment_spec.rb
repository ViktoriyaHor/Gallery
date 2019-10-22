# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject! { create :comment, user_id: user.id, image_id: image.id }
  let(:user) { create :user }
  let(:image) { create :image }

  context 'validation' do
    it { is_expected.to be_valid }

    it 'check dependent destroy from user' do
      expect { user.destroy }.to change { Comment.count }.by(-1)
    end

    it 'check dependent destroy from category' do
      expect { image.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
