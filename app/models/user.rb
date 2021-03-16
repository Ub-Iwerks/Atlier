class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :default_avatar
  has_one_attached :avatar
  has_many :works, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :omniauthable, :validatable, password_length: 8..128
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, on: :create
  validates :avatar, content_type: { in: %w(image/jpeg image/gif image/png), message: "有効なファイルを選択してください" },
                     size: { less_than: 5.megabytes, message: "5MB以下を選択してください" }
  validates :description, length: { maximum: 250 }
  VALID_URL_REGEX = %r{https?://[\w!?/\+\-_~=;\.,*&@#$%\(\)\'\[\]]+}.freeze
  validates :website, format: { with: VALID_URL_REGEX, allow_nil: true }, length: { maximum: 150 }

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

  def default_avatar
    if !avatar.attached?
      avatar.attach(io: File.open('app/assets/images/avatar.png'), filename: 'avatar.png', content_type: 'image/png')
    end
  end

  def feed
    Work.where("user_id = ? OR user_id IN (?)", id, Relationship.where(follower_id: id).select(:followed_id))
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
end
