class RemoveWorkIdFromSeries < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :series, :works
    remove_index :series, :work_id
    remove_column :series, :work_id, :bigint
  end
end
