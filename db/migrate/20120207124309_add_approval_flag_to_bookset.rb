class AddApprovalFlagToBookset < ActiveRecord::Migration
  def change
    add_column :booksets, :approval_flag, :integer, :default => 0
  end
end
