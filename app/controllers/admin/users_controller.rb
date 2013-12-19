class Admin::UsersController < ApplicationController
    layout 'admin/application'
    before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

    #before_filter :signed_in_user, only: [:index, :edit, :update]
    #before_filter :correct_user, only: [:edit, :update]
    before_filter :signed_in_user
    before_filter { access_only_roles %w[ROLE_ADMIN] }


    def index
        store_location
        @users = User.paginate(page: params[:page])
    end

    def show
    end	

    def new
        @user = User.new
        @user.customer = Customer.new
    end

    def create
        @user = User.new(admin_user_params)
        if @user.save
            sign_in @user
            flash[:success] = t("_WELCOME")
            redirect_to admin_users_path
        else
            render 'new'
        end
    end

    def edit  
        #@user.customer = Customer.find_by_user_id(@user)   
    end

    def update
        if @user.update(admin_user_params)
            flash[:success] = t("_EDIT_USER_SUCCESS")
            redirect_back_or admin_users_path
        else
            render 'edit'
        end
    end  

    def destroy
        @user.destroy
        redirect_to admin_users_path
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_admin_user
            @user = User.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end 
end
