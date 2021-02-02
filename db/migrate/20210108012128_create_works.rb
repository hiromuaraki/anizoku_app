class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :season_name
      t.string :season_name_text
      t.integer :season_year, null: false
      t.string :title, null: false, unique: true
      t.integer :episodes_count, default: 0, null: false
      t.string :facebook_og_image_url, default: "", null: false
      t.date :released_at
      t.string :media, null: false
      t.string :media_text, null: false
      t.string :official_site_url, default: "", null: false
      t.string :twitter_hashtag
      t.string :twitter_image_url, default: "", null: false
      t.string :twitter_username
      t.string :recommended_image_url, default: "", null: false
      t.string :wikipedia_url, default: "", null: false

      t.timestamps
    end
  end
end
