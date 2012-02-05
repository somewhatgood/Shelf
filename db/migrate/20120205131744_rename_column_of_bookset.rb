class RenameColumnOfBookset < ActiveRecord::Migration
  def up
  	rename_column :booksets, :image_url, :image
  end

  def down
  end
end
