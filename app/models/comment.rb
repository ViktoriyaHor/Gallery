class Comment < ApplicationRecord
  belongs_to :image
  validates :commenter, :body, presence: true
  paginates_per 5
end
