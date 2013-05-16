class Admin::GalleryImagesController < ApplicationController
  layout 'admin/application'
  before_filter :admin_only
    
  # GET /admin/gallery_images
  # GET /admin/gallery_images.json
  def index
    store_location
    @images = GalleryImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
    end
  end

  # GET /admin/gallery_images/1
  # GET /admin/gallery_images/1.json
  def show
    store_location
    @images = GalleryImage.find(:all, :conditions => { :gallery_id => params[:id] })
    @image = GalleryImage.new
    @gallery = Gallery.find(params[:id])
  end

  # GET /admin/gallery_images/new
  # GET /admin/gallery_images/new.json
  def new
    @image = GalleryImage.new
    @image.gallery_id = params[:gallery_id]
  end


  # POST /admin/gallery_images
  # POST /admin/gallery_images.json
  def create
    res = false
    # пакетная загрузка изображений
    if params[:gallery_image][:path].present?
      params[:gallery_image][:path].each do |f|      
        @image = GalleryImage.new(:gallery_id => params[:gallery_image][:gallery_id], :path => f)
        res = @image.save
        break if res != true
      end
    end

    if res
      flash[:info] = t('_SUCCESSFULLY_UPLOADED')
      redirect_to admin_gallery_image_path(params[:gallery_image][:gallery_id])  
    else  
      flash[:error] = t('_ERROR_UPLOAD')
      redirect_to new_admin_gallery_image_path
    end

  end


  # GET /admin/gallery_images/1/edit
  def edit
    @image = GalleryImage.find(params[:id])
  end

  # PUT /admin/gallery_images/1
  # PUT /admin/gallery_images/1.json
  def update
    @image = GalleryImage.find(params[:id])

    if @image.update_attributes(params[:gallery_image])
      flash[:info] = t('_IMAGE_SUCCESSFULLY_UPDATED')
      if params[:continue].present? 
        redirect_to edit_admin_gallery_image_path(@image)
      else
        redirect_back_or admin_gallery_path(@image.gallery_id)
      end
    else
      render action: "edit"
    end
  end

  # DELETE /admin/gallery_images/1
  # DELETE /admin/gallery_images/1.json
  def destroy
    @image = GalleryImage.find(params[:id])
    @image.destroy

    redirect_back_or admin_galleries_path
  end

  def uppload
    @image = GalleryImage.new
    @image.path = params[:gallery_image]
    puts "==================="
    puts params[:gallery_image].inspect
    puts "==================="

    # image.path = params[:file]
    # image.path = File.open('somewhere')
    if @image.save
      flash[:info] = t('_SUCCESSFULLY_CREATED')

      if params[:continue].present? 
        redirect_to edit_admin_gallery_image_path(@image)
      else
        redirect_back_or admin_gallery_path(@image.gallery_id)
      end    
    else  
      flash[:error] = "Не загрузили изображение"
      redirect_to admin_gallery_image_path(15)
    end 
  end
end
