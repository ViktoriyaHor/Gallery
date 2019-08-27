class Subscription < ApplicationRecord
  belongs_to :category, counter_cache: true
  belongs_to :user

end
