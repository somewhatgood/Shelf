class ChangeColumnOfApply < ActiveRecord::Migration
  def up
  	change_column(:applies, :omniuser_id, :integer )
  	change_column(:applies, :bookset_id, :integer )
  end

  def down
  end
end
