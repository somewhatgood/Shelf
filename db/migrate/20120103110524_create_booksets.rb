class CreateBooksets < ActiveRecord::Migration
  def change
    create_table :booksets do |t|
      t.string :description,:limit => 99
      t.string :category, :limit => 20
      t.string :image_url

      t.timestamps
    end
  end
end
