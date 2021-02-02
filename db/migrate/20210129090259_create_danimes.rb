class CreateDanimes < ActiveRecord::Migration[6.0]
  def change
    create_table :danimes do |t|
      t.references :tag, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
