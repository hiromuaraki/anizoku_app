class AddImageThumbnailToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :image_thumbnail, :string, default: "", null: false, limit: 255, after: :episodes_count
  end
end
