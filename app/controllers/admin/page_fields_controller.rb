class Admin::PageFieldsController < ApplicationController
  # GET /admin/page_fields
  # GET /admin/page_fields.json
  def index
    @admin_page_fields = PageField.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_page_fields }
    end
  end

  # GET /admin/page_fields/1
  # GET /admin/page_fields/1.json
  def show
    @admin_page_field = PageField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_page_field }
    end
  end

  # GET /admin/page_fields/new
  # GET /admin/page_fields/new.json
  def new
    @admin_page_field = PageField.new
    @admin_page_field.page_id = params[:page_id] if !params[:page_id].blank?
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_page_field }
    end
  end

  # GET /admin/page_fields/1/edit
  def edit
    @admin_page_field = PageField.find(params[:id])
  end

  # POST /admin/page_fields
  # POST /admin/page_fields.json
  def create
    @admin_page_field = PageField.new(params[:admin_page_field])

    respond_to do |format|
      if @admin_page_field.save
        format.html { redirect_to @admin_page_field, notice: 'Page field was successfully created.' }
        format.json { render json: @admin_page_field, status: :created, location: @admin_page_field }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_page_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/page_fields/1
  # PUT /admin/page_fields/1.json
  def update
    @admin_page_field = PageField.find(params[:id])

    respond_to do |format|
      if @admin_page_field.update_attributes(params[:admin_page_field])
        format.html { redirect_to @admin_page_field, notice: 'Page field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_page_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/page_fields/1
  # DELETE /admin/page_fields/1.json
  def destroy
    @admin_page_field = PageField.find(params[:id])
    @admin_page_field.destroy

    respond_to do |format|
      format.html { redirect_to admin_page_fields_url }
      format.json { head :no_content }
    end
  end
end
