class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, index: true
      t.references :resource, polymorphic: true, index: true
      t.integer :role, index: true 

      t.timestamps null: false
    end
    add_foreign_key :user_roles, :users
  end
end
