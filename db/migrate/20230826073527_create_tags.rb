class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_index :tags, [:title], unique: true
  end
end
