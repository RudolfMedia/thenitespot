class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :sort

      t.timestamps null: false
    end
    add_index :categories, :sort
  end
end
