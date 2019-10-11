require 'rails_helper'

RSpec.describe Category, type: :model do

  let(:user) { create :user }
  subject(:category) { create :category, title: 'Cats', user_id: user.id }

  context 'validation' do

    it "is valid with valid attributes" do
      expect(category).to be_valid
    end

    it 'has a uniq title' do
      subject
      category2 = build :category, title: 'Cats'
      expect(category2).to_not be_valid
    end

  end

  context 'associations' do

    it 'has many images' do
      is_expected.to respond_to :images
      expect(category.images.to_a).to eq []
      image = category.images.create!(src: "#{Rails.root}/app/assets/images/cats/cat-694730_1920.jpg", user_id: user.id)
      expect(category.reload.images).to eq [image]
    end

    it 'has many subscriptions' do
      is_expected.to respond_to :subscriptions
      expect(category.subscriptions.to_a).to eq []
      subscription = category.subscriptions.create!(user_id: user.id)
      expect(category.reload.subscriptions).to eq [subscription]
    end

    it 'check dependent destroy from user' do
      subject
      expect { user.destroy }.to change { Category.count }.by(-1)
    end

  end
end
