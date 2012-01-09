class AddOmniuserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniuser_id, :integer
  end
end
