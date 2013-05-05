require 'test_helper'

class Admin::PageFieldsControllerTest < ActionController::TestCase
  setup do
    @admin_page_field = admin_page_fields(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_page_fields)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_page_field" do
    assert_difference('Admin::PageField.count') do
      post :create, admin_page_field: { name: @admin_page_field.name, position: @admin_page_field.position, string: @admin_page_field.string, value: @admin_page_field.value }
    end

    assert_redirected_to admin_page_field_path(assigns(:admin_page_field))
  end

  test "should show admin_page_field" do
    get :show, id: @admin_page_field
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_page_field
    assert_response :success
  end

  test "should update admin_page_field" do
    put :update, id: @admin_page_field, admin_page_field: { name: @admin_page_field.name, position: @admin_page_field.position, string: @admin_page_field.string, value: @admin_page_field.value }
    assert_redirected_to admin_page_field_path(assigns(:admin_page_field))
  end

  test "should destroy admin_page_field" do
    assert_difference('Admin::PageField.count', -1) do
      delete :destroy, id: @admin_page_field
    end

    assert_redirected_to admin_page_fields_path
  end
end
