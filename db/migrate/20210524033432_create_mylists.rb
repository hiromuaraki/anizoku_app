class CreateMylists < ActiveRecord::Migration[6.0]
  def change
    create_table :mylists do |t|
      t.references :work, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
    add_index :mylists,[:work_id,:user_id ],unique: true
  end
end
