class AddDescriptionToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :description, :text, limit: 4294967295
    add_column :works, :description_source, :string, limit: 255, default: ""
  end
end
