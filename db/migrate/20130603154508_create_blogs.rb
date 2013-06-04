class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.foreign_key :users, column: 'user_id', options: 'ON DELETE CASCADE'

      t.string :title, :null => false
      t.text :spost, :null => false
      t.text :post, :null => false
      t.string :slug, :null => false
      t.integer :status, :default => 1
      t.boolean :active, :default => true
      t.boolean :has_comments, :default => true
      t.integer :num_comments, :default => 0
      t.date :publish_date, :null => false

      t.timestamps
    end
    add_index :blogs, :slug, :unique => true

    create_table :blog_comments do |t|
      t.integer :user_id
      t.foreign_key :users, column: 'user_id', options: 'ON DELETE CASCADE'

      t.integer :parent_id
      t.foreign_key :blog_comments, column: 'parent_id', options: 'ON DELETE CASCADE'

      t.text :comment, :null => false
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
