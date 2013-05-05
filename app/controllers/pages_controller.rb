class PagesController < ApplicationController

  # GET /pages
  # GET /pages.json
  def index
    if params[:url] == 'index'
      render :template => 'site/not_found', :status => 404
      return
    end

    url = (params[:url] ? params[:url] : 'index')  
    if !@page = Page.find_by_path(url)
      render :template => 'site/not_found', :status => 404
    end  
  end 
end
