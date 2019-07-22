class Image < ApplicationRecord
  mount_uploader :wave_src, ImageUploader
  belongs_to :category
  # validates :wave_src, presence: true
end
