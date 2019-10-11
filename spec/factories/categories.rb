FactoryBot.define do
  factory :category do
    title { Faker::Name.name }
    user

    factory :category_with_image do
      # transient do
      #   images_count { 1 }
      # end
      # after(:create) do |category, evaluator|
      #   create_list(:image, evaluator.images_count, category: category)
      # end
      after(:create) do |category|
        create :image, category: category
      end
    end
  end
end