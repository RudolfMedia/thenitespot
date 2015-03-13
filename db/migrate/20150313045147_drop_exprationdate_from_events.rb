class DropExprationdateFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :expiration_date 
  end
end
