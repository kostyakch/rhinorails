class PageComment < ActiveRecord::Migration
  def change
    create_table :page_comments do |t|
      t.integer :user_id
      t.foreign_key :users, column: 'user_id', options: 'ON DELETE CASCADE'

      t.integer :page_id
      t.foreign_key :pages, column: 'page_id'

      t.integer :parent_id
      t.foreign_key :page_comments, column: 'parent_id', options: 'ON DELETE CASCADE'

      t.text :comment, :null => false
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
