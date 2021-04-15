class CreateWikilists < ActiveRecord::Migration[6.0]
  def change
    create_table :wikilists do |t|
      t.string :title, null: false, unique: true
      t.string :organization, limit: 255

      t.timestamps
    end
  end
end
