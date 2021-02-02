class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.references :work, null: false, foreign_key: true
      t.text :name
      t.string :role_text
      t.string :role_other

      t.timestamps
    end
  end
end
