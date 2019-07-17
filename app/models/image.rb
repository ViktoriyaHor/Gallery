class Image < ApplicationRecord
  mount_uploader :wave_src, ImageUploader
  belongs_to :category
end
