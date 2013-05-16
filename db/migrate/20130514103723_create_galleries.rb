class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :page_id
      t.foreign_key :pages, options: 'ON DELETE CASCADE'
    	
      t.string :url, :limit  => 150, :null => true
      t.string :name, :limit  => 255, :null => false
      t.text :descr
      t.boolean :active, :default => true
      t.integer :position, :default => 0

      t.timestamps
    end
    add_index :galleries, :url, :unique => true
    add_index :galleries, :name, :unique => true

  end
end