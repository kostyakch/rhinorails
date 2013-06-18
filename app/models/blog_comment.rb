class BlogComment < ActiveRecord::Base
	attr_accessible :comment, :approved, :blog_id, :parent_id

	belongs_to :blog, :inverse_of => :blog_comment	
	accepts_nested_attributes_for :blog

	belongs_to :user

	# Validations
	validates :comment, presence: true
	validates :comment, length: { minimum: 3, maximum: 255 }


	def children
		BlogComment.where('parent_id = ?', self.id)
	end

end
