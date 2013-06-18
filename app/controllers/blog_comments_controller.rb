class BlogCommentsController < ApplicationController

	def new
		@blog_comment = BlogComment.new
		@user = User.new
	end

	def create
		params[:blog_comment][:approved] = Rails.configuration.blogcomments_approved
		@blog_comment = BlogComment.new(params[:blog_comment])
		@blog = Blog.find_by_id(params[:blog_comment][:blog_id])

		# Попытаемся найти пользователя по емаил
		@user = User.find_by_email(params[:user][:email])
		if @user.present?
			@user.update_attributes(params[:user])			
		else
			@user = User.new(params[:user])
			@user.password = 10.times.map{ 20 + Random.rand(11) } # рандомный пароль
			@user.password_confirmation = @user.password
			@user.save
		end
		
		if !@user.id.present? 
			render action: "new"
			return
		end

		@blog_comment.user = @user
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
