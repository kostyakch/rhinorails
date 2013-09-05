class Admin::PageCommentsController < ApplicationController
  layout 'admin/application'

  before_filter :signed_in_user
  before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }

  def index
  	store_location
    @page_comments = PageComment.where('parent_id is null').order('page_id, approved, updated_at').paginate(page: params[:page])
  end

  def edit
    @page_comment = PageComment.find(params[:id])    
  end

  def update
    @page_comment = PageComment.find(params[:id])

    if @page_comment.update_attributes(params[:page_comment])
      flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
      if params[:continue].present? 
        render action: "edit"
      else
        redirect_back_or admin_page_comments_path
      end      
    else
      render action: "edit"
    end   
  end  

  def destroy
    page_comment = PageComment.find(params[:id]).destroy

    flash[:info] = t('_PAGE_COMMENT_SUCCESSFULLY_DELITED')
    redirect_back_or admin_page_comments_path
  end
end
