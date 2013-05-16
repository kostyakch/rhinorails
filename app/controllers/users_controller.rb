class UsersController < ApplicationController
  #before_filter :signed_in_user, only: [:index, :edit, :update]
  #before_filter :correct_user, only: [:edit, :update]
  #before_filter :admin_only, only: [:edit, :update, :destroy]

  def new
  	@user = User.new
  end

	def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user

    	flash[:success] = t("_WELCOME")
      redirect_to root_path
    else
      render 'new'
    end
  end

end
