FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    confirmed_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    # after :create do |user|
    #   create :action, action_type: 'navigation'
    #   create_list :logging_user_action, 3, user: user, action: action
    # end
  end
end
