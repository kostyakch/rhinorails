class Admin::UsersController < ApplicationController
  layout 'admin/application'

  #before_filter :signed_in_user, only: [:index, :edit, :update]
  #before_filter :correct_user, only: [:edit, :update]
  before_filter :signed_in_user
  before_filter { access_only_roles %w[ROLE_ADMIN] }


  def index
    @users = User.paginate(page: params[:page])
  end

	def show
		@user = User.find(params[:id])
	end	

  def new
  	@user = User.new
  end

	def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    	flash[:success] = t("_WELCOME")
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      
      flash[:success] = t("_EDIT_USER_SUCCESS")
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end  

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

end
