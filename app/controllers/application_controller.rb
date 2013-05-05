class ApplicationController < ActionController::Base
  include SessionsHelper

	# before_filter :set_locale
	 
	# def set_locale
	#   I18n.locale = params[:locale] || I18n.default_locale
	# end  



  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  	
  private    
    def signed_in_user
      unless signed_in?
        store_location

        flash[:error] = t('_SIGN_IN')
        redirect_to login_url
      end
    end   
    
    def correct_user
      if params[:id]
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)   
      end
    end

    def admin_only      
      unless signed_in? && has_role?('ROLE_ADMIN')
        store_location
        redirect_to login_url
      end       
    end 
end
