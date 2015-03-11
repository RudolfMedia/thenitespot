class AddIndexToExpirationDateOnEvents < ActiveRecord::Migration
  
  def change
  	add_index :events, :expiration_date 
  end
end
