class CreateCasts < ActiveRecord::Migration[6.0]
  def change
    create_table :casts do |t|
      t.references :character, null: false, foreign_key: true
      t.string :work_title
      t.string :name
      t.string :name_kana
      t.string :gender
      t.string :blood_type
      t.string :birthday
      t.string :url
      t.string :wikipedia_url

      t.timestamps
    end
  end
end
