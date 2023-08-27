class Tagging < ApplicationRecord
  # Relations
  belongs_to :tag
  belongs_to :work

  # Validation
  validates :work_id,
      presence: true,
      uniqueness: { scope: :tag_id,
          message: "同様のタグは付与できません"
      }
  validates :tag_id,
      presence: true
end