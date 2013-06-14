class BlogCommentsController < ApplicationController

	def new
		@blog_comment = BlogComment.new		
	end

	def create
		params[:blog_comment][:approved] = Rails.configuration.blogcomments_approved
		@blog_comment = BlogComment.new(params[:blog_comment])
		@blog = Blog.find_by_id(params[:blog_comment][:blog_id])

		if @blog_comment.save
			if Rails.configuration.blogcomments_approved
				flash[:info] = t('_BLOG_COMMENT_SUCCESSFULLY_CREATED')
			else
				flash[:info] = t('_BLOG_COMMENT_SUCCESSFULLY_WAITING_FOR_MODERATION')
			end
			redirect_back_or blog_show_path(@blog_comment.blog.slug)
		else
			render action: "new"
		end
	end
end
