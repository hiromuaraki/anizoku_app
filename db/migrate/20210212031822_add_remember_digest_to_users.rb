class AddRememberDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remember_digest, :string, after: :password_digest
  end
end