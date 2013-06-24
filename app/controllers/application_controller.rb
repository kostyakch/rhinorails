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

    # Проверяем пользовательские роли, переданные в массиве "roles"
    # В случае, если роли не найдены переадресуем пользователя на страницу авторизации
    def access_only_roles(roles)
      access = false
      roles.each do |r| 
        access = has_role?( r )
        break if access
      end

      if not access
        store_location        
        
        # Если пользователь имеет роль "ROLE_EDITOR", отобразим страницу ошибки
        # Если пользователь НЕ имеет роль "ROLE_EDITOR", отправим на страницу авторизации
        if current_user.roles.split(',').include? 'ROLE_EDITOR' 
          render :template => 'site/err_403', :status => 403
        else
          flash[:error] = t('No permissions to perform this operation.')
          redirect_to login_url
        end
      end
    end 
end
