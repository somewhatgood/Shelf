class ChangeTablenameOfUsers < ActiveRecord::Migration
  def up
  	rename_table :users, :omniusers
  end

  def down
  	rename_table :omniusers, :users
  end
end
