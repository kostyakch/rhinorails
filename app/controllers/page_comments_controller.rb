class PageCommentsController < ApplicationController

	def new
		@page_comment = PageComment.new
		@page_comment.user = User.new
	end

	def create
		@page = Page.find(params[:page_comment][:page_id])
		
		params[:page_comment][:approved] = Rails.configuration.comments_approved
		params[:page_comment][:user_attributes][:id] = nil
		@page_comment = PageComment.new(page_comment_params)
		

		# Попытаемся найти пользователя по емаил
		user = User.find_by_email(params[:page_comment][:user_attributes][:email].downcase)
		if user
			# Нашли пользователя в БД. Нужно удалить user_attributes, чтобы не обновлять пользователя
			params[:page_comment].delete(:user_attributes)
			@page_comment = PageComment.new(params[:page_comment])

			@page_comment.user_id = user.id
		else
			password = 10.times.map{ 20 + Random.rand(11) }
			@page_comment.user.password = @page_comment.user.password_confirmation = password			
		end

		@info = t('_BLOG_COMMENT_SUCCESSFULLY_WAITING_FOR_MODERATION')
		@info = t('_BLOG_COMMENT_SUCCESSFULLY_CREATED') if Rails.configuration.comments_approved
	    respond_to do |format|
			if @page_comment.save
				format.html { 
					flash[:info] = @info
					redirect_to page_path(@page.slug) 
				}
				format.js { }
			else
				format.html { render action: "new" }
				format.js { }
			end
	    end
	end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_page_comment
           
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def page_comment_params
            params.require(:page_comment).permit!#(:name, :position, :active, questions_attributes: [:name])
        end	
end
