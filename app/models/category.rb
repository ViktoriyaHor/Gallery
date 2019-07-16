class Category < ApplicationRecord
  # mount_uploader :image, ImageUploader
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :images
end
