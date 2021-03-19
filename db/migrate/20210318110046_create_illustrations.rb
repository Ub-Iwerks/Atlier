class CreateIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :illustrations do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
    add_index :illustrations, [:work_id, :created_at]
  end
end
