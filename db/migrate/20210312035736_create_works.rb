class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string :title
      t.text :concept
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :works, [:user_id, :created_at]
  end
end
