class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name, unique: true
      t.string :nick_name
      t.string :birthday
      t.string :age
      t.string :blood_type
      t.text   :description
      t.string :description_source

      t.timestamps
    end
  end
end
