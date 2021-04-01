class AddIsDeletedToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :is_deleted, :boolean, default: true, after: :wikipedia_url
  end
end
