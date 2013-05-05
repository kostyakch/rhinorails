class Admin::PagesController < ApplicationController
	layout 'admin/application'
	before_filter :admin_only


	def index
		store_location
	end

	def new
    	@page = Page.new
    	@page.parent_id = params[:parent_id] if !params[:parent_id].blank?
    	default_attr(@page)  	
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
		default_attr(@page)

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @page }
	    end  		
	end

	def update
		@page = Page.find(params[:id])
		update_page_content
		update_page_field

		if @page.update_attributes(params[:page])

			flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
			redirect_to admin_pages_path
		else
			render action: "edit"
		end
	end

	def destroy
		page = Page.find(params[:id]).destroy

		flash[:info] = t('_PAGE_SUCCESSFULLY_DELITED', name: page.name)
		redirect_to admin_pages_path
	end

	def showhide
		page = Page.find(params[:id])
		page.update_attributes( :active => !page.active? )

		redirect_back_or admin_pages_path
	end

	private
		def default_attr(page)
			if page.page_content.where("name = 'main_content'").empty?
				page.page_content.build(name: "main_content")	
			end
	    	
	    	if page.page_field.where("name = 'description'").empty?
		    	page.page_field.build( name: "description", ftype: 'meta', position: 0 )
	    	end 
	    	if page.page_field.where("name = 'keywords'").empty?
		    	page.page_field.build( name: "keywords", ftype: 'meta', position: 1 )
	    	end 			
		end

		# Обновим контети страницы (добавим/удалим)
		def update_page_content
			
		end

		# Обновим контети страницы (добавим/удалим)
		def update_page_field
			
		end
end
