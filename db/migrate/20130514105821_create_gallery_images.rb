class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.integer :gallery_id
      t.foreign_key :galleries, options: 'ON DELETE CASCADE'

      t.string :path, :limit  => 150
      t.text :annotation
      t.boolean :main,  :default => false, :null => false
      t.boolean :active, :default => true, :null => false
      t.integer :position, :default => 0, :null => false

      t.timestamps
    end
    add_index :gallery_images, [:gallery_id, :path], :unique => true

  end
end
