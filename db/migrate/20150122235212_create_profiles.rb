class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date   :dob
      t.string :current_city
      t.string :current_state

      t.timestamps null: false
    end
    add_foreign_key :profiles, :users
  end
end
