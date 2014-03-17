class UsersController < ApplicationController

    def new
    	@user = Rhinoart::User.new
    end

    def create
        @user = Rhinoart::User.new(user_params)
        if @user.save
          sign_in @user

        	flash[:success] = t("_WELCOME")
          redirect_to root_path
        else
          render 'new'
        end
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end   
end
