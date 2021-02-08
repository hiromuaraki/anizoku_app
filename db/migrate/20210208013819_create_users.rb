class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, default: "ゲストユーザー"
      t.string :email,null: false
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :display_mode, default: false
      
      t.index :email, unique: true
      t.timestamps
    end
  end
end
