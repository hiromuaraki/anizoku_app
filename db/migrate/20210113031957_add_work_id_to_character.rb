class AddWorkIdToCharacter < ActiveRecord::Migration[6.0]
  def change
    add_reference :characters, :work, null: false, foreign_key: true, after: :id, default: 0
  end
end
