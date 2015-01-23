class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.string :label
      t.string :name
      t.string :state
      t.float  :longitude
      t.float  :latitude

      t.timestamps null: false
    end
    add_index :neighborhoods, [ :latitude, :longitude ]
  end
end
