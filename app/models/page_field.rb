class PageField < ActiveRecord::Base
	belongs_to :page, :inverse_of => :page_field	
	accepts_nested_attributes_for :page

	default_scope { order 'position' }
	acts_as_list scope: :page_id

	FIELD_TYPES = { title: 'Meta title', meta: 'Meta description', text: 'Text', textarea: 'Textarea', image: 'Image' }

	validates :name, :ftype, presence: true
	validates_uniqueness_of :name, :scope => :page_id

	validates :ftype, inclusion: { in: FIELD_TYPES.keys.map(&:to_s) }

	def select_list
		FIELD_TYPES.map { |ft| [ft[1], ft[0]] }
	end
end
