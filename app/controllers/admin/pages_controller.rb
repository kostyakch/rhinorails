class Admin::PagesController < ApplicationController
	before_filter :admin_only

	def index
		@pages = Page.paginate(page: params[:page])
	end

	def new
    	@page = Page.new
	end

	def create
		@page = Page.new
		if @page.update_attributes(params[:page])

			flash[:info] = t('_PAGE_SUCCESSFULLY_CREATED')
			redirect_to admin_pages_path
		else	
			render 'new'
		end
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
		if @page.update_attributes(params[:page])

			flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
			redirect_to admin_pages_path
		else
			render action: "edit"
		end
	end

	def destroy
		Page.find(params[:id]).destroy
		redirect_to admin_pages_path
	end


end
