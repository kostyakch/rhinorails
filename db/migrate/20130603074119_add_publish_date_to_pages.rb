class AddPublishDateToPages < ActiveRecord::Migration
  def change
    change_table :pages do |t|
      t.date :publish_date, :null => false
    end   	
  end
end
