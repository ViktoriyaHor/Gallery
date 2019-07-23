class Comment < ApplicationRecord
  belongs_to :image
  validates :commenter, :body, presence: true
end
