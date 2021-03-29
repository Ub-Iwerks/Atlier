class AddCategoryIdToWorks < ActiveRecord::Migration[6.1]
  def change
    add_reference :works, :category, foreign_key: true
  end
end
