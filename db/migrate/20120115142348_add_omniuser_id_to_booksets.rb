class AddOmniuserIdToBooksets < ActiveRecord::Migration
  def change
    add_column :booksets, :omniuser_id, :integer
  end
end
