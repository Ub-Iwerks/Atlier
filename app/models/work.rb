class Work < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :illustrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
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

  def display_image_square(size: 600, main: false)
    if main
      image.variant(gravity: :center, resize: "848x848^", crop: "848x600+0+0").processed
    else
      image.variant(gravity: :center, resize: "#{size}x#{size}^", crop: "#{size}x#{size}+0+0").processed
    end
  end
end
