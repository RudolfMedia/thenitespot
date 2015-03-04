class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.integer :sort
      t.references :spot, index: true

      t.timestamps null: false
    end
    add_foreign_key :menus, :spots
  end
end
