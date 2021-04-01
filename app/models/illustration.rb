class Illustration < ApplicationRecord
  before_create :add_position_count
  belongs_to :work
  has_one_attached :photo
  validates :name, length: { maximum: 50 }
  validates :description, length: { maximum: 150 }
  validates :photo, content_type: { in: %w(image/jpeg image/gif image/png), message: "有効なファイルを選択してください" },
                    size: { less_than: 5.megabytes, message: "5MB以下を選択してください" }
  validate :image_presence, :works_attached_limit

  def attached_count
    work.illustrations.count.to_i
  end

  def add_position_count
    position_count = attached_count + Settings.attached_count[:addition]
    self.position = position_count
  end

  def image_presence
    errors.add(:photo, "ファイルを添付してください。") unless photo.attached?
  end

  def works_attached_limit
    if attached_count >= Settings.attached_count[:maximum]
      errors.add(:work, "1つの作品添付可能なファイルは#{Settings.attached_count[:maximum]}つまでです。")
    end
  end

  def display_photo_square(size: 600)
    photo.variant(gravity: :center, resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
  end
end
