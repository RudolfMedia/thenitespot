class ChangeNameOfDayToDays < ActiveRecord::Migration
  
  def change
   change_table :specials do |t|
    t.rename :day, :days
   end

   change_table :hours do |t|
   	t.rename :day, :days 
   end
  end 
  
end
