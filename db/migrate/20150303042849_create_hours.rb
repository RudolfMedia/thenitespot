class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.references :spot, index: true
      t.string :day, array: true, default: [] 
      t.time :open,  null: false
      t.time :close, null: false
      t.string :note

      t.timestamps null: false
    end
    add_foreign_key :hours, :spots
  end
end
