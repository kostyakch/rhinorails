require 'test_helper'

class Admin::GalleryImagesControllerTest < ActionController::TestCase
  setup do
    @admin_gallery_image = admin_gallery_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_gallery_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_gallery_image" do
    assert_difference('Admin::GalleryImage.count') do
      post :create, admin_gallery_image: { active: @admin_gallery_image.active, annotation: @admin_gallery_image.annotation, main: @admin_gallery_image.main, path: @admin_gallery_image.path, position: @admin_gallery_image.position }
    end

    assert_redirected_to admin_gallery_image_path(assigns(:admin_gallery_image))
  end

  test "should show admin_gallery_image" do
    get :show, id: @admin_gallery_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_gallery_image
    assert_response :success
  end

  test "should update admin_gallery_image" do
    put :update, id: @admin_gallery_image, admin_gallery_image: { active: @admin_gallery_image.active, annotation: @admin_gallery_image.annotation, main: @admin_gallery_image.main, path: @admin_gallery_image.path, position: @admin_gallery_image.position }
    assert_redirected_to admin_gallery_image_path(assigns(:admin_gallery_image))
  end

  test "should destroy admin_gallery_image" do
    assert_difference('Admin::GalleryImage.count', -1) do
      delete :destroy, id: @admin_gallery_image
    end

    assert_redirected_to admin_gallery_images_path
  end
end
