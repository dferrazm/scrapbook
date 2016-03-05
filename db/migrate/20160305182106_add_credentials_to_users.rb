class AddCredentialsToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username
    add_column :users, :password_digest, :string
  end
end
