class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  validates :src, presence: true
end
