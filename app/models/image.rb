class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :category
  validates :src, presence: true
end
