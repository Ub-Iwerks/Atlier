class AddDescriptionToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :description, :text
  end
end
