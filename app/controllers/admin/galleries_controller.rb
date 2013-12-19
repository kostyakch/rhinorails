class Admin::GalleriesController < ApplicationController
    layout 'admin/application'
    before_action :set_admin_gallery, only: [:edit, :update, :destroy]

    before_filter :signed_in_user
    before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR] }

    def index
        store_location
        @galleries = Gallery.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @galleries }
        end
    end

    def new
        @gallery = Gallery.new
        @galleries = Gallery.all

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @gallery }
        end
    end

    def create
        @gallery = Gallery.new(admin_gallery_params)
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

    def edit
        @galleries = Gallery.all
    end

    def update
        if @gallery.update(admin_gallery_params)
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

    def destroy
        @gallery.destroy

        respond_to do |format|
            format.html { redirect_to admin_galleries_url }
            format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_admin_gallery
            @gallery = Gallery.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def admin_gallery_params
            params.require(:gallery).permit(:active, :descr, :name, :url)
        end    
end
