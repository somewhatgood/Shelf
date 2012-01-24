class AddImageToOmniuser < ActiveRecord::Migration
  def change
    add_column :omniusers, :image, :string
  end
end
