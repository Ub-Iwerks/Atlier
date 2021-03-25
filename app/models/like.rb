class Like < ApplicationRecord
  belongs_to :work
  belongs_to :user
  validates_uniqueness_of :work_id, scope: :user_id
end
