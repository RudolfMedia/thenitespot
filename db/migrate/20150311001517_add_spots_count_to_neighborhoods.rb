class AddSpotsCountToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :spots_count, :integer, default: 0 
  end
end
