class AddSeasonIdToWork < ActiveRecord::Migration[6.0]
  def change
    add_reference :works, :season, null: false, foreign_key: true, after: :id
  end
end
