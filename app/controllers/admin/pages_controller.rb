class Admin::PagesController < ApplicationController
	before_filter :signed_in_user 

	def index
		@pages = Page.all   
	end

	def new
    	@page = Page.new
    	@page_path = admin_pages_path
	end

	def create
		@page = Page.new
		if @page.update_attributes(params[:page])

			flash[:notice] = t('_PAGE_SUCCESSFULLY_CREATED')
			redirect_to admin_pages_path
		else
			render action: "new"
		end
	end

	def edit
		@page = Page.find(params[:id])
		@page_path = admin_page_path
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])

			flash[:notice] = t('_PAGE_SUCCESSFULLY_UPDATED')
			redirect_to admin_pages_path
		else
			render action: "edit"
		end
	end


	def destroy
		@page = Page.find(params[:id])
		if @page.destroy
			redirect_to admin_pages_path
		else
			render action: "index"
		end
	end
end
