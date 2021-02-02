class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 255, unique: true
      t.string :name_kana, limit: 255
      t.string :name_en, limit: 255, unique: true
      t.text :url
      t.text :wikipedia_url
      t.string :twitter_name

      t.timestamps
    end
  end
end
