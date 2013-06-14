class BlogsController < ApplicationController

	def show
		store_location
		if !@blog = Blog.where('active = ? and slug = ?', true, params[:slug]).first
			render :template => 'site/not_found', :status => 404
		else
			@blog_comments = BlogComment
				.where('parent_id is null and approved = ? and blog_id = ?', true, @blog.id)
				.order('updated_at')
				.paginate(page: params[:page])

			@blog_comment = BlogComment.new
		end		
	end
end
