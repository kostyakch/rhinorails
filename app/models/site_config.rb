class SiteConfig < ActiveRecord::Base
	set_table_name "config"
	attr_accessible :name, :value
end
