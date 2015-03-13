class AddExpirationDateIndexToOccurrences < ActiveRecord::Migration
  def change
  	add_index :occurrences, :expiration_date 
  end
end
