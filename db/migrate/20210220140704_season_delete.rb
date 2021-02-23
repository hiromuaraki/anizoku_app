class SeasonDelete < ActiveRecord::Migration[6.0]
  def change
    drop_table :seasons
  end
end
