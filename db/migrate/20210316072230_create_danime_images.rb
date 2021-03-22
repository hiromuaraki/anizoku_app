class CreateDanimeImages < ActiveRecord::Migration[6.0]
  def change
    create_table :danime_images do |t|
      t.string :title, unique: true
      t.string :image_url, default: "", null: false, limit: 255

      t.timestamps
    end
  end
end
