class Admin::SettingsController < ApplicationController
	layout 'admin/application'
	before_filter :admin_only

	def index
		store_location
		@settings = Setting.all
	end

	def new
		@setting = Setting.new
	end

	def create
		@setting = Setting.new		

		if @setting.update_attributes(params[:setting])

			flash[:info] = t('_SUCCESSFULLY_CREATED')
			if params[:continue].present? 
				redirect_to edit_admin_setting_path(@setting)
			else
				redirect_back_or admin_settings_path
			end			
		else
			render 'new'
		end
	end

	def edit
		@setting = Setting.find(params[:id])
	end

	def update
		@setting = Setting.find(params[:id])

		if @setting.update_attributes(params[:setting])	

			flash[:info] = t('_SUCCESSFULLY_UPDATED', name: @setting.name)
			if params[:continue].present? 
				render action: "edit"
			else
				redirect_back_or admin_settings_path
			end
		else
			render "edit"
		end
	end

	def destroy
		setting = Setting.find(params[:id]).destroy

		flash[:info] = t('_SUCCESSFULLY_DELITED', name: setting.name)
		redirect_back_or admin_settings_path		
	end
end
