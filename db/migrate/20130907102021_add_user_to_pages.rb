class AddUserToPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.integer :user_id
      t.foreign_key :users, column: 'user_id'
    end   	
  end
end
