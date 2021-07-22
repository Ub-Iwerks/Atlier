class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create do
    avatar.attach(io: File.open("#{Settings.default_image[:avatar_path]}"), filename: "#{Settings.default_image[:avatar]}")
  end
  has_one_attached :avatar
  has_many :works, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :work
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :footprints, dependent: :destroy
  has_many :stocks, dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :omniauthable, :validatable, password_length: 8..128
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :avatar, content_type: { in: %w(image/jpeg image/gif image/png), message: "有効なファイルを選択してください" },
                     size: { less_than: 5.megabytes, message: "5MB以下を選択してください" }
  validates :description, length: { maximum: 250 }
  VALID_URL_REGEX = %r{https?://[\w!?/\+\-_~=;\.,*&@#$%\(\)\'\[\]]+}.freeze
  validates :website, format: { with: VALID_URL_REGEX }, length: { maximum: 150 }, allow_blank: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      username: auth.info.name,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      confirmed_at: Time.current
    )
    user
  end

  def feed
    Work.
      select("works.*, SUM(footprints.counts) AS total_footprint_counts").
      joins(:footprints).
      includes(
        [
          :comments,
          :likes,
          image_attachment: :blob,
          user: { avatar_attachment: :blob },
          illustrations: { photo_attachment: :blob },
        ]
      ).where(
        "works.user_id = ? OR works.user_id IN (?)",
        id,
        Relationship.where(follower_id: id).select(:followed_id)
      ).group("works.id")
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def already_commented?(work)
    comments.exists?(work_id: work.id)
  end

  def already_liked?(work)
    likes.exists?(work_id: work.id)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
