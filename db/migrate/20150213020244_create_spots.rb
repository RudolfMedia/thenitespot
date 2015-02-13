class CreateSpots < ActiveRecord::Migration
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')

    create_table :spots do |t|
      t.string :name,              null: false, default: ""
      t.string :slug 
      t.boolean :eat, index: true
      t.boolean :drink, index: true
      t.boolean :attend, index: true 
      t.string :street            
      t.string :city              
      t.string :state             
      t.string :zip               
      t.float :latitude, index: true
      t.float :longitude, index: true
      t.references :neighborhood, index: true
      t.string :phone
      t.string :email
      t.text :about
      t.string :price, index: true 
      t.string :payment_opts, array: true, default: []
      t.string :website_url
      t.string :reservation_url
      t.string :menu_url
      t.string :facebook_url
      t.string :twitter_url

      t.timestamps null: false
    end
    add_index :spots, [:slug], unique: true
    add_foreign_key :spots, :neighborhoods
  end
end
