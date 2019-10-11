FactoryBot.define do
  factory :action do
    action_type { %w(navigation user_sign_in user_sign_out likes comments).sample }
    end
end
