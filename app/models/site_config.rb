class SiteConfig < ActiveRecord::Base
	self.table_name = 'config'
	attr_accessible :name, :value
end
