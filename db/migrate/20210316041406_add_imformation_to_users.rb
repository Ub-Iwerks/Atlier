class AddImformationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :description, :text
    add_column :users, :website, :text
  end
end
