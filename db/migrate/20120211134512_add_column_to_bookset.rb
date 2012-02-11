class AddColumnToBookset < ActiveRecord::Migration
  def change
    add_column :booksets, :offering_flag, :integer
    add_column :booksets, :offered_flag, :integer
  end
end
