class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.string :bookset_id
      t.string :omniuser_id

      t.timestamps
    end
  end
end
