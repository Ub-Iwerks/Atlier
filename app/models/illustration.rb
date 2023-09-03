class Illustration < ApplicationRecord
  before_create :add_position_count
  # Relations
  belongs_to :work
  has_one_attached :photo

  # Validation
  validates :name,
    length: { maximum: 50 }
  validates :description,
    length: { maximum: 150 }
  validates :photo,
    content_type: {
      in: %w(image/jpeg image/gif image/png),
      message: "有効なファイルを選択してください"
    },
    size: {
      less_than: 5.megabytes,
      message: "5MB以下を選択してください"
    },
    presence: { message: 'を添付してください。' }
  validate :works_attached_limit

  def add_position_count
    position_count = work.illustrations.count.to_i + Settings.attached_count[:addition]
    self.position = position_count
  end

  def works_attached_limit
    if work.illustrations.count.to_i >= Settings.attached_count[:maximum]
      errors.add(:work, "1つの作品添付可能なファイルは#{Settings.attached_count[:maximum]}つまでです。")
    end
  end

  def display_photo_square(size: 600)
    photo.variant(gravity: :center, resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
  end
end
