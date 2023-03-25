class RemoveColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :email, :string
    remove_index  :users, column: :email, name: 'index_users_on_email'
    remove_column :users, :password_digest, :string
    remove_column :users, :remember_digest, :string
    remove_column :users, :display_mode, :boolean
  end
end
