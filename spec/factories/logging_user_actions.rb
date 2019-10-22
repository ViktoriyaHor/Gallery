# frozen_string_literal: true

FactoryBot.define do
  factory :logging_user_action do
    action
    user
  end
end
