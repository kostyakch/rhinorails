class Admin::BlogsController < ApplicationController
  layout 'admin/application'

  before_filter :signed_in_user
  before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }

  def index
    store_location
    @blogs = Blog.paginate(page: params[:page])
  end

  # GET /admin/blogs/1
  # GET /admin/blogs/1.json
  def show
    @blog = Blog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blog }
    end
  end

  def new
    @blog = Blog.new
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(params[:blog])

    if @blog.save
      flash[:info] = t('_PAGE_SUCCESSFULLY_CREATED')
      if params[:continue].present? 
        render action: "edit"
      else
        redirect_back_or admin_blogs_path
      end 
    else
      render action: "new"
    end
  end

  def update
    @blog = Blog.find(params[:id])

    if @blog.update_attributes(params[:blog])
      flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
      if params[:continue].present? 
        render action: "edit"
      else
        redirect_back_or admin_blogs_path
      end      
    else
      render action: "edit"
    end   
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_back_or admin_blogs_url
  end
end
