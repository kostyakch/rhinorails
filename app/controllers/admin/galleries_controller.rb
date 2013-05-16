class Admin::GalleriesController < ApplicationController
  layout 'admin/application'
  before_filter :admin_only
    
  # GET /admin/galleries
  # GET /admin/galleries.json
  def index
    store_location
    @galleries = Gallery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /admin/galleries/new
  # GET /admin/galleries/new.json
  def new
    @gallery = Gallery.new
    @galleries = Gallery.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gallery }
    end
  end

  # POST /admin/galleries
  # POST /admin/galleries.json
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.url = nil if @gallery.url.empty?
    if @gallery.save
      flash[:info] = t('_SUCCESSFULLY_CREATED')

      if params[:continue].present? 
        redirect_to edit_admin_gallery_path(@gallery)
      else
        redirect_back_or admin_galleries_path
      end     
    else  
      render 'new'
    end

  end

  # GET /admin/galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
    @galleries = Gallery.all
  end

  # PUT /admin/galleries/1
  # PUT /admin/galleries/1.json
  def update
    @gallery = Gallery.find(params[:id])

    if @gallery.update_attributes(params[:gallery])
      flash[:info] = t('_PAGE_SUCCESSFULLY_UPDATED')
      if params[:continue].present? 
        render action: "edit"
      else
        redirect_back_or admin_galleries_path
      end
    else
      render action: "edit"
    end
  end


  # DELETE /admin/galleries/1
  # DELETE /admin/galleries/1.json
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to admin_galleries_url }
      format.json { head :no_content }
    end
  end
end
