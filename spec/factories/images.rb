# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    src { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/cats/cat-694730_1920.jpg'), 'image/jpeg') }
    category
    user
    factory :image_with_comment do
      after(:create) do |image|
        create :comment, image: image
      end
    end
    factory :image_with_like do
      transient do
        likes_count { 5 }
      end
      after(:create) do |image, evaluator|
        create_list(:like, evaluator.likes_count, image: image)
      end
    end
  end
end
