class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.integer :bookset_id
      t.integer :bookset_approved_id

      t.timestamps
    end
  end
end
