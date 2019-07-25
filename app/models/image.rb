class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :src, presence: true
end
