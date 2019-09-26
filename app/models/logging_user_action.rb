# frozen_string_literal: true

class LoggingUserAction < ApplicationRecord
  belongs_to :user
  belongs_to :action
end
