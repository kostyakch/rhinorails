class Admin::SettingsController < ApplicationController
	layout 'admin/application'
	before_action :set_admin_setting, only: [:edit, :update, :destroy]

	before_filter :signed_in_user
	before_filter { access_only_roles %w[ROLE_ADMIN] }

	def index
		store_location
		@settings = Setting.all
	end

	def new
		@setting = Setting.new
	end

	def create
		@setting = Setting.new(admin_setting_params)
		if @setting.save

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
	end

	def update
		if @setting.update(admin_setting_params)	
			setting_by_name(@setting.name, true)
			
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
		setting_name = @setting.name
		@setting.destroy

		flash[:info] = t('_SUCCESSFULLY_DELITED', name: setting_name)
		redirect_back_or admin_settings_path		
	end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_admin_setting
            @setting = Setting.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_setting_params
            params.require(:setting).permit! #(:name, :value, :descr)
        end 	
end
