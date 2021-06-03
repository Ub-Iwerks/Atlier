class AddIndexFootprintsUserId < ActiveRecord::Migration[6.1]
  def change
    add_index :footprints, [:user_id, :work_id], unique: true
  end
end
