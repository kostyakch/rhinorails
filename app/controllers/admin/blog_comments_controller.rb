class Admin::BlogCommentsController < ApplicationController
  layout 'admin/application'
  before_filter :admin_only

  def index
  	store_location
    @blog_comments = BlogComment.where('parent_id is null').order('blog_id, approved, updated_at').paginate(page: params[:page])
  end

  def edit
    @blog_comment = BlogComment.find(params[:id])
  end

  def update
    @blog_comment = BlogComment.find(params[:id])

    if @blog_comment.update_attributes(params[:blog_comment])
      flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
      if params[:continue].present? 
        render action: "edit"
      else
        redirect_back_or admin_blog_comments_path
      end      
    else
      render action: "edit"
    end   
  end  
end
