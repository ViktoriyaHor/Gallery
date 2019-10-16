FactoryBot.define do
  factory :category do
    title { Faker::Name.name }
    user

    factory :category_with_image do
      after(:create) do |category|
        create :image, category: category
      end
    end

    factory :category_with_subscription do
      after(:create) do |category|
        create :subscription, category: category
      end
    end
  end
end