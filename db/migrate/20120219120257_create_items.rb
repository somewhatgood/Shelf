class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :omniuser_id
      t.string :description
      t.string :category
      t.string :image
      t.integer :offered_flag
      t.integer :offering_flag
      t.integer :approval_flag

      t.timestamps
    end
  end
end
