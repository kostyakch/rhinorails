class Admin::BlogCommentsController < ApplicationController
  layout 'admin/application'
  before_filter :admin_only

  def index
    @comments = BlogComment.paginate(page: params[:page])
  end	
end
