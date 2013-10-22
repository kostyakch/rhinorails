class PagesController < ApplicationController
  caches_page :index, :internal
  
  def index
    if params[:url] == 'index'
      render :template => 'site/not_found', :status => 404
      return
    end

    if !@page = Page.find_by_path('index')
      render :template => 'site/not_found', :status => 404
    end  
  end 

  def internal
    if params[:url] == 'index'
      render :template => 'site/not_found', :status => 404
      return
    end
    
    if !@page = Page.find_by_path(params[:url])
      render :template => 'site/not_found', :status => 404
      return
    end
  end
end
