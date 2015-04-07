class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user, index: true
      t.references :reportable, polymorphic: true, index: true
      t.integer :issue

      t.timestamps null: false
    end
    add_foreign_key :reports, :users
  end
end
