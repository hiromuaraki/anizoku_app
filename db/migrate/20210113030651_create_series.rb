class CreateSeries < ActiveRecord::Migration[6.0]
  def change
    create_table :series do |t|
      t.references :work, null: false, foreign_key: true, unique: true
      t.string :name

      t.timestamps
    end
  end
end
