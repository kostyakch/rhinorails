# == Schema Information
#
# Table name: page_contents
#
#  id      :integer          not null, primary key
#  page_id :integer
#  name    :string(100)      not null
#  content :text
#

class PageContent < ActiveRecord::Base
	belongs_to :page, :inverse_of => :page_content	
	accepts_nested_attributes_for :page

	#attr_accessible :name, :content
	#default_scope order: 'page_content.order DESC'
end


