class Admin::PagesController < ApplicationController

  def index
    @page = Page.find(1)
	respond_to do |format|
		format.html # index.html.erb
		format.json { render json: @pages }
	end
  end
end
