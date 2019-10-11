FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::String.random(length: 5..20) }
    user
    image
  end
end