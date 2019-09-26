class Action < ApplicationRecord
  has_many :logging_user_actions, dependent: :destroy
  # enum action_type: %i[navigation user_sign_in user_sign_out likes comments ]
end
