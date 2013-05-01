class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_only, only: [:edit, :update, :destroy]


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
    	flash[:success] = "_WELCOME"
      redirect_to @user
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
      sign_in @user
      flash[:success] = "_EDIT_USER_SUCCESS"
      redirect_to @user
    else
      render 'edit'
    end
  end  

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

end
