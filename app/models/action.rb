class Action < ApplicationRecord
  has_many :logging_user_actions, dependent: :destroy
end
