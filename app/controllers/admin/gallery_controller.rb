class Admin::GalleryController < ApplicationController
	layout 'admin/application'
	before_filter :admin_only	
	
	def index
	end

	def new
	end

	def edit
	end

	def destroy
	end
end
