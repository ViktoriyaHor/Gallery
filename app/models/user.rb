class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, :trackable
         # :lockable
  has_many :categories, dependent: :destroy
  has_many :likes, dependent: :destroy

  # attr_accessor :failed_attempts

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid, username: auth.info.name).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.logins_before_captcha
    3
  end
end
