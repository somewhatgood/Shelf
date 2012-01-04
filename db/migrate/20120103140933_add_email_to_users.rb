class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :pw_digest, :string, :limit => 20
  end
end
