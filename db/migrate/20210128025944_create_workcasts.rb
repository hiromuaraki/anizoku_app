class CreateWorkcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :workcasts do |t|
      t.references :work, null: false, foreign_key: true
      t.references :cast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
