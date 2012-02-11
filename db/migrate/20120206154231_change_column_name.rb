class ChangeColumnName < ActiveRecord::Migration
  def up
  	rename_column :offers, :bookset_offered_id, :bookset_id
  end

  def down
  end
end
