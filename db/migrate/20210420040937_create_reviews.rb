class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :work, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :rate, default: 0, null: false
      t.float :rating_drawing,default: 0, null: false
      t.float :rating_story,default: 0, null: false
      t.float :rating_actor,default: 0, null: false
      t.float :rating_incidental_music,default: 0, null: false
      t.float :rating_directing,default: 0, null: false
      t.float :rating_characters,default: 0, null: false
      t.text :content
      

      t.timestamps
    end
    add_index :reviews,[:work_id,:user_id ],unique: true
  end
end
