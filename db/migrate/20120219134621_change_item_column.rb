class ChangeItemColumn < ActiveRecord::Migration
  def change
  	change_column_default :items, :approval_flag, 0
  	change_column_default :items, :offered_flag, 0
  	change_column_default :items, :offering_flag, 0
  end
end
