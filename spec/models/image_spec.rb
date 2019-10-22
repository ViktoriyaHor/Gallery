# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  subject(:image) { create :image }
  let(:user_id) { (create :user).id }

  context 'validation' do
    it { is_expected.to be_valid }
  end

  context 'associations' do
    it 'has many likes' do
      is_expected.to respond_to :likes
      expect(image.likes.to_a).to eq []
      like = image.likes.create!(user_id: user_id)
      expect(image.reload.likes).to eq [like]
    end
    it 'has many comments' do
      is_expected.to respond_to :comments
      expect(image.comments.to_a).to eq []
      comment = image.comments.create!(commenter: 'Bob', body: 'fine', user_id: user_id)
      expect(image.reload.comments).to eq [comment]
    end
  end
end
