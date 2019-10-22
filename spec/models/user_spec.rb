# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject!(:user) { create :user, username: 'Bob', email: 'bob@gmail.com' }
  let(:category_id) { ( create :category).id }
  let(:image_id) { ( create :image ).id }

  context 'validation' do
    it {is_expected.to be_valid}
    it 'has a unique email' do
      user2 = build(:user, username: 'Bob')
      expect(user2).to_not be_valid
    end
    it 'has a unique username' do
      user2 = build(:user, email: 'bob@gmail.com')
      expect(user2).to_not be_valid
    end
    it 'is not valid without a password' do
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end
    it 'is not valid without a username' do
      user2 = build(:user, username: nil)
      expect(user2).to_not be_valid
    end
    it 'is not valid without an email' do
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many categories' do
      is_expected.to respond_to :categories
      expect(user.categories.to_a).to eq []
      category = user.categories.create!(title: 'category1')
      expect(user.reload.categories).to eq [category]
    end
    it 'has many images' do
      is_expected.to respond_to :images
      expect(user.images.to_a).to eq []
      image = user.images.create!(src: "#{Rails.root}/app/assets/images/cats/cat-694730_1920.jpg", category_id: category_id)
      expect(user.reload.images).to eq [image]
    end
    it 'has many subscriptions' do
      is_expected.to respond_to :subscriptions
      expect(user.subscriptions.to_a).to eq []
      subscription = user.subscriptions.create!(category_id: category_id)
      expect(user.reload.subscriptions).to eq [subscription]
    end
    it 'has many likes' do
      is_expected.to respond_to :likes
      expect(user.likes.to_a).to eq []
      like = user.likes.create!(image_id: image_id)
      expect(user.reload.likes).to eq [like]
    end
    it 'has many comments' do
      is_expected.to respond_to :comments
      expect(user.comments.to_a).to eq []
      comment = user.comments.create!(commenter: 'Bob', body: 'fine', image_id: image_id)
      expect(user.reload.comments).to eq [comment]
    end
  end
end
