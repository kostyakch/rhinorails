class BlogComment < ActiveRecord::Base
   attr_accessible :comment, :active

   belongs_to :blog, :inverse_of => :blog_comment	
   accepts_nested_attributes_for :blog
end
