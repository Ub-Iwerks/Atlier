class CreateFootprints < ActiveRecord::Migration[6.1]
  def change
    create_table :footprints do |t|
      t.integer :counts, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
