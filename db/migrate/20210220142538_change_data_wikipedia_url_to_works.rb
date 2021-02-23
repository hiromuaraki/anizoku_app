class ChangeDataWikipediaUrlToWorks < ActiveRecord::Migration[6.0]
  def change
    change_column :works, :wikipedia_url, :text, default: nil
  end
end
