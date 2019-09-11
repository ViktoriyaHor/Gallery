# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  paginates_per 6
end
