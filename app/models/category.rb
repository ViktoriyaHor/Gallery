# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :images, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, uniqueness: true
end
