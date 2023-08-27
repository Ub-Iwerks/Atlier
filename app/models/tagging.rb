class Tagging < ApplicationRecord
    validates :work_id,
        presence: true,
        uniqueness: { scope: :tag_id,
            message: "同様のタグは付与できません"
        }
    validates :tag_id,
        presence: true
end