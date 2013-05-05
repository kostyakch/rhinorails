class PageField < ActiveRecord::Base
	belongs_to :page, :inverse_of => :page_field	
	accepts_nested_attributes_for :page

	attr_accessible :name, :position, :string, :value, :ftype
end
