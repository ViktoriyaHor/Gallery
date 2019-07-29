class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, :trackable
  has_many :likes, dependent: :destroy
  attr_accessor :email, :password, :password_confirmation, :remember_me
  attr_accessor :nickname, :provider, :url, :username
end
