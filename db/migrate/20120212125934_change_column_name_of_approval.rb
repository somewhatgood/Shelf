class ChangeColumnNameOfApproval < ActiveRecord::Migration
  def change
  	rename_column :approvals, :bookset_approved_id, :bookset_pair_id
  end
end
