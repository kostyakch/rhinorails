class CreateRhinoTables < ActiveRecord::Migration
  def self.up
    create_table :config do |t|
      t.string :name, :limit  => 120, :default => "", :null => false
      t.string :value, :limit => 255, :default => "", :null => false
    end
    add_index :config, [:name, :value], :unique => true 

    create_table :pages do |t|
      t.integer :parent_id
      t.foreign_key :pages, column: 'parent_id'

      t.string :name, :null => false
      t.string :slug, :null => false, :limit => 100
      t.integer :position, :default => 0, :null => false
      t.integer :visible, :default => true
      t.integer :menu, :default => true
      t.boolean :active, :default => true
      t.string  :sm_p,  :limit => 7, :default => "weekly", :null => false
      t.decimal :st_pr, :precision => 10, :scale => 2, :default => 0.5, :null => false

      t.timestamps
    end
    add_index :pages, [:parent_id, :slug], :unique => true


    create_table :page_contents, :force => true do |t|
      t.integer :page_id
      t.foreign_key :pages

      t.string :name, :limit => 100, :null => false
      t.text :content
    end
    add_index :page_contents, :name
    add_index :page_contents, [:page_id, :name], :unique => true

    create_table :users do |t|
      t.string :name, :limit => 250 #, :null => false
      t.string :email, :limit => 100 , :null => false
      t.boolean :active, :default => true, :null => false
      t.string :roles, :default => "ROLES_USER", :null => false
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true

  end  

  def self.down
    drop_table "page_contents"
    drop_table "pages"
    drop_table "users"
    drop_table "config"
  end
end
