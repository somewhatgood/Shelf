class DeleteColumns < ActiveRecord::Migration
  def change
  	remove_column :Offers, :bookset_id
  	remove_column :Offers, :bookset_offering_id
  	remove_column :Approvals, :bookset_id
  	remove_column :Approvals, :bookset_pair_id
  end
end
