class RemoveEmailPwDigestFromOmniusers < ActiveRecord::Migration
  def up
  	remove_column :omniusers, :email
  	remove_column :omniusers, :pw_digest
  end

  def down
  	add_column :omniusers, :email, :string
  	add_column :omniusers, :pw_digest, :string
  end
end
