class CreateAdminPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_posts do |t|
      t.string :title, null: false, limit: 255, unique: true
      t.string :image

      t.timestamps
    end
  end
end
