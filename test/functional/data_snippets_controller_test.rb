require 'test_helper'

class DataSnippetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_snippets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create data_snippet" do
    assert_difference('DataSnippet.count') do
      post :create, :data_snippet => { }
    end

    assert_redirected_to data_snippet_path(assigns(:data_snippet))
  end

  test "should show data_snippet" do
    get :show, :id => data_snippets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => data_snippets(:one).to_param
    assert_response :success
  end

  test "should update data_snippet" do
    put :update, :id => data_snippets(:one).to_param, :data_snippet => { }
    assert_redirected_to data_snippet_path(assigns(:data_snippet))
  end

  test "should destroy data_snippet" do
    assert_difference('DataSnippet.count', -1) do
      delete :destroy, :id => data_snippets(:one).to_param
    end

    assert_redirected_to data_snippets_path
  end
end
