class CreateMenuSections < ActiveRecord::Migration
  def change
    create_table :menu_sections do |t|
      t.references :menu, index: true
      t.string :name
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :menu_sections, :menus
  end
end
