class Image < ApplicationRecord
  mount_uploader :src, ImageUploader
  # mount_uploader :remote_src_url, ImageUploader
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :src, presence: true
  paginates_per 6

  after_create :send_email_to_subscribers

  private

  def send_email_to_subscribers
    Resque.enqueue(NewImageSendEmail, self.id)
    # UserMailer.new_image(self.id).deliver
  end
end
