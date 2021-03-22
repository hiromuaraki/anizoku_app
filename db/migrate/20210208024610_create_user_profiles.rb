class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :nick_name ,default: "ゲストユーザー"
      t.string :word

      t.timestamps
    end
  end
end