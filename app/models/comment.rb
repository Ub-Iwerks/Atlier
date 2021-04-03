class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :work
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 150 }
end
