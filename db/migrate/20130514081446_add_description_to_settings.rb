class AddDescriptionToSettings < ActiveRecord::Migration
  def change
    change_table :settings do |t|
      t.text :descr, :null => true
    end  	  	
  end
end
