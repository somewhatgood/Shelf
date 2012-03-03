class AddColumnToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :item_id, :integer
    add_column :approvals, :item_pair_id, :integer
  end
end
