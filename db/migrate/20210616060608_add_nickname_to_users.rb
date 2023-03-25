class AddNicknameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string, after: :name
  end
end
