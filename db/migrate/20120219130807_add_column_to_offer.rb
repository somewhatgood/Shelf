class AddColumnToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :item_id, :integer
    add_column :offers, :item_offering_id, :integer
  end
end
