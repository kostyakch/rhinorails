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
	belongs_to :page

	attr_accessible :page_id, :name, :content
end
