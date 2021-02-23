class RemoveSeasonFromWorks < ActiveRecord::Migration[6.0]
  def change
    remove_column :works, :season_id
  end
end
