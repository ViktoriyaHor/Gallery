# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :image, counter_cache: true
  belongs_to :user
end
