class Work < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :illustrations, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :concept, length: { maximum: 300 }
  validates :description, length: { maximum: 300 }
  validates :image, content_type: { in: %w(image/jpeg image/gif image/png), message: "有効なファイルを選択してください" },
                    size: { less_than: 5.megabytes, message: "5MB以下を選択してください" }
  validate :image_presence

  def image_presence
    errors.add(:image, "ファイルを添付してください。") unless image.attached?
  end

  def display_image
    image.variant(resize_to_limit: [250, 250])
  end
end
