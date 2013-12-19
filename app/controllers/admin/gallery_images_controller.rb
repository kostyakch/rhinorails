class Admin::GalleryImagesController < ApplicationController
    layout 'admin/application'
    before_action :set_admin_gallery_image, only: [:edit, :update, :destroy]

    before_filter :signed_in_user
    before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }

    def index
        store_location
        @images = GalleryImage.all
    end

    def show
        store_location
        @images = GalleryImage.where('gallery_id = ?', params[:id])
        @image = GalleryImage.new
        @gallery = Gallery.find(params[:id])
    end

    def new
        @image = GalleryImage.new
        @image.gallery_id = params[:gallery_id]
    end

    def create
        res = false
        if params[:gallery_image][:path].present?
            params[:gallery_image][:path].each do |f|      
                @image = GalleryImage.new(gallery_id: params[:gallery_image][:gallery_id], path: f)
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

    def edit
    end

    def update
        if @image.update(admin_gallery_image_params)
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

    def destroy
        @image.destroy

        redirect_back_or admin_galleries_path
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_admin_gallery_image
            @image = GalleryImage.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_gallery_image_params
            params.require(:gallery_image).permit!#(:active, :annotation, :main, :path, :position, :gallery_id, :path_cache, :images_attributes)
        end 
end
