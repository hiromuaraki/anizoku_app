class CreateWorkSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :work_series do |t|
      t.references :work, null: false, foreign_key: true
      t.references :series, null: false, foreign_key: true

      t.timestamps
    end
    add_index :work_series,[:work_id,:series_id ],unique: true
  end
end
