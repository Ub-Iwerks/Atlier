class Category < ApplicationRecord
  has_many :works
  has_ancestry
end
