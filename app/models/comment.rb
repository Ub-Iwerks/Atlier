class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :content, presence: true, length: { maximum: 150 }
end
