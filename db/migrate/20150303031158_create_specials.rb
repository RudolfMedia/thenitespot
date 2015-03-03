class CreateSpecials < ActiveRecord::Migration
  def change
    create_table :specials do |t|
      t.references :spot,   index: true
      t.string :name, null: false
      t.string :description
      t.string :day,        array: true, default: []
      t.time :start_time
      t.time :end_time
      t.integer :sort, null: false 

      t.timestamps null: false
    end
    add_foreign_key :specials, :spots
  end
end
