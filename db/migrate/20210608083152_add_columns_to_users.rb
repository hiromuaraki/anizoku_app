class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uid, :string, after: :id, null: false
    add_column :users, :provider, :string, after: :uid
    add_column :users, :url, :string, after: :image, limit: 255
  end
end
