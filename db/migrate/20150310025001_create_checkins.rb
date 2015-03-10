class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user, index: true
      t.references :spot, index: true

      t.timestamps null: false
    end
    add_foreign_key :checkins, :users
    add_foreign_key :checkins, :spots
  end
end
