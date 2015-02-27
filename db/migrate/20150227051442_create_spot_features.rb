class CreateSpotFeatures < ActiveRecord::Migration
  def change
    create_table :spot_features do |t|
      t.references :spot, index: true
      t.references :feature, index: true

      t.timestamps null: false
    end
    add_foreign_key :spot_features, :spots
    add_foreign_key :spot_features, :features
  end
end
