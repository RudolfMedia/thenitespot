class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, default: "", null: false 
      t.string :slug
      t.text :about
      t.string :age
      t.string :entry
      t.string :entry_fee
      t.references :spot, index: true
      t.string :phone
      t.string :email
      t.string :ticket_url 
      t.string :website_url
      t.string :facebook_url
      t.string :twitter_url
      t.date :expiration_date

      t.timestamps null: false
    end
    add_foreign_key :events, :spots
    add_index :events, :slug 
  end
end
