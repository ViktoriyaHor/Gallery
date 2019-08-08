class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :src, presence: true
  paginates_per 5

  after_create :send_email_to_subscribers

  private

  def send_email_to_subscribers
    UserMailer.new_image(self).deliver
  end
end
