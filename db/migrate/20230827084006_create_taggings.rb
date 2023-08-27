class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.references :work, foreign_key: true, column: :work_id
      t.references :tag,  foreign_key: true, column: :tag_id

      t.timestamps
    end

    add_index :taggings, [:work_id, :tag_id], unique: true
  end
end
