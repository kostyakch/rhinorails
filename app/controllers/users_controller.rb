class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create] #only: [:edit, :update]
  before_filter :correct_user, except: [:new, :create]   #only: [:edit, :update]

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
 
end
