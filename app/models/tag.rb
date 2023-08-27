class Tag < ApplicationRecord
  # Relations
  has_many :taggings, dependent: :destroy
  has_many :works, through: :taggings

  # Validation
  validates :title,
      presence: true,
      uniqueness: true,
      length: { maximum: 255 }
end
