class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.float :price
      t.references :menu_section, index: true

      t.timestamps null: false
    end
    add_foreign_key :menu_items, :menu_sections
  end
end
