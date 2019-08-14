class Comment < ApplicationRecord
  belongs_to :image, counter_cache: true
  belongs_to :user
  validates :commenter, :body, presence: true
  paginates_per 5
end
