class CreateOccurrences < ActiveRecord::Migration
  def change
    create_table :occurrences do |t|
      t.references :event, index: true
      t.date :start_date, null: false
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.date :expiration_date, null: false 

      t.timestamps null: false
    end
    add_foreign_key :occurrences, :events
  end
end
