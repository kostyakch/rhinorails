class Admin::PageFieldsController < ApplicationController
	layout 'admin/application'
	
	before_filter :signed_in_user
	before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }	

	def new
	end

	def create
		@field = PageField.new(admin_page_params)

		respond_to do |format|
			if @field.valid?
				format.js { }
			else
				format.js { }
			end
		end	
	end

    def destroy
    	begin
            @field = PageField.find(params[:id])
    		@field.destroy
    	rescue
    	end        

        respond_to do |format|
            format.js { }
        end
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_page_params
            params.require(:page_field).permit!
        end 	
end
