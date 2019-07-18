class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :images
  validates :title, presence: true, uniqueness: true
            # length: { minimum: 5 }
end
