class PageComment < ActiveRecord::Base
	attr_accessible :comment, :approved, :page_id, :parent_id

	belongs_to :page, :inverse_of => :page_comment	
	accepts_nested_attributes_for :page

	belongs_to :user

	# Validations
	validates :comment, presence: true
	validates :comment, length: { minimum: 3, maximum: 255 }


	def children
		PageComment.where('parent_id = ?', self.id)
	end

end
