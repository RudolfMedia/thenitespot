class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :categorizable, polymorphic: true
      t.references :category 

      t.timestamps null: false
    end
    add_index :categorizations, :categorizable_id
    add_index :categorizations, :categorizable_type
    add_index :categorizations, :category_id 
  end
end
