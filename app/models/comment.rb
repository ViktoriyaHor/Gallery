class Comment < ApplicationRecord
  belongs_to :image, counter_cache: true
  validates :commenter, :body, presence: true
  paginates_per 5
end
