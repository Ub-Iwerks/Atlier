class User < ApplicationRecord
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :omniauthable
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
