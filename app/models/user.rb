class User < ApplicationRecord
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :omniauthable, :validatable, password_length: 8..128
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, on: :create
end
