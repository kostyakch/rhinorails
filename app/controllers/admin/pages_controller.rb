class Admin::PagesController < ApplicationController
	layout 'admin/application'
	before_filter :admin_only


	def index(parent = nil)
		store_location
		if parent.blank?
			@pages = Page.paginate(page: params[:page]).where("parent_id IS NULL AND active = ?", true)	
		else
			@pages = Page.paginate(page: params[:page]).where("parent_id = ? AND active = ?", parent.id, true) if parent.ptype == 'page'
		end			
	end

	def children
		store_location

		@parent = Page.find(params[:parent_id])
		@pages = Page.where("parent_id = ?", params[:parent_id]).order('publish_date DESC')
	end

	def new
    	@page = Page.new
    	@pages_for_select = pages_for_select    	

    	if params[:parent_id].present?
	    	@page.parent_id = params[:parent_id]
	       	@page.ptype = Page.find(@page.parent_id).ptype
    	end

    	default_fields(@page)
    	default_content(@page)
	end

	def create
		@page = Page.new		
		@pages_for_select = pages_for_select

		if @page.update_attributes(params[:page])

			flash[:info] = t('_PAGE_SUCCESSFULLY_CREATED')
			if params[:continue].present? 
				redirect_to edit_admin_structure_path(@page)
			else
				redirect_back_or admin_pages_path
			end			
		else	
			render 'new'
		end
	end

	def edit		
		@page = Page.find(params[:id])
		@pages_for_select = pages_for_select params[:id]
	end

	def update
		@page = Page.find(params[:id])

		@pages_for_select = pages_for_select params[:id]
		if @page.update_attributes(params[:page])
			update_page_field(@page, params[:page]) # Обновим данные о page_field
			update_page_content(@page, params[:page])		

			flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
			if params[:continue].present? 
				render action: "edit"
			else
				redirect_back_or admin_pages_path
			end
		else
			render action: "edit"
		end
	end

	def tree
		store_location
	end
	
	def destroy
		page = Page.find(params[:id]).destroy

		flash[:info] = t('_PAGE_SUCCESSFULLY_DELITED', name: page.name)
		redirect_back_or admin_pages_path
	end

	def showhide
		page = Page.find(params[:id])
		page.update_attributes( :active => !page.active? )

		redirect_back_or admin_pages_path
	end

	def sort
		params[:page].each_with_index do |id, index|
			Page.update_all(['position=?', index+1], ['id=?', id])
		end
		render :nothing => true
	end


	private
		def default_content(page)
			page.page_content.build(name: "main_content") if page.page_content.where("name = 'main_content'").empty?
		end

		def default_fields(page)	    	
			page.page_field.build( name: "title", ftype: 'title', position: 0 )
			page.page_field.build( name: "h1", ftype: 'title', position: 1 )
			page.page_field.build( name: "description", ftype: 'meta', position: 2 )
	    	page.page_field.build( name: "keywords", ftype: 'meta', position: 3 )
		end

		# Обновим page_field (добавим/удалим)
		def update_page_field(page, params)
			# Создадим массив существующих полей
			originalFields = []
			page.page_field.each { |f| originalFields << f }

			# filter originalFields to contain params no longer present	
			if params[:page_field_attributes].present?	
				params[:page_field_attributes].each do |fk, fv|
					originalFields.each do |of|
						originalFields.delete(of) if of.name.to_s.downcase == fv[:name].to_s.downcase
					end
				end
			end

			originalFields.each { |f| f.destroy }
		end

		# Обновим контети страницы (добавим/удалим)
		def update_page_content(page, params)
			# Создадим массив существующих полей
			originalTabs = []
			page.page_content.each { |f| originalTabs << f }

			# filter originalTabs to contain params no longer present	
			if params[:page_content_attributes].present?	
				params[:page_content_attributes].each do |fk, fv|
					originalTabs.each do |of|
						originalTabs.delete(of) if of.name.to_s.downcase == fv[:name].to_s.downcase
					end
				end
			end

			# remove the relationship between the param and the Content
			originalTabs.each { |f| f.destroy }			
		end

		def pages_for_select(id = nil)
			if id.present?
				Page.where("ptype != 'article' AND id != ?", id).order('name')
			else
				Page.where("ptype != 'article'").order('name')				
			end			
		end

end
