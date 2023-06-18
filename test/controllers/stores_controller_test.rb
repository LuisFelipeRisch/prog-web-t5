require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Should be possible to enter in index page of stores without be logged in" do
    get stores_path

    assert_response :success
  end

  test "Should be possible to enter in show page of stores without be logged in" do
    store = stores(:one)

    get store_path(store)

    assert_response :success
  end

  test "User should be redirected to log in page if enter in new store, without being logged in" do
    get new_store_path

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if enter in edit store, without being logged in" do
    store = stores(:one)

    get edit_store_path(store)

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to edit store, without being logged in" do
    store = stores(:one)

    params = {
      store: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    patch store_path(store), params: params

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to create new store, without being logged in" do
    params = {
      store: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    post stores_path, params: params

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to delete a store, without being logged in" do
    store = stores(:one)

    delete store_path(store)

    assert_redirected_to new_user_session_path
  end

  test "Should render forbidden page if user is not admin and tries to enter in the new page" do
    user = users(:one)
    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    get new_store_path

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to enter in the edit page" do
    user = users(:one)
    store = stores(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    get edit_store_path(store)

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to enter in the edit a store" do
    user = users(:one)
    store = stores(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    params = {
      store: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    patch store_path(store), params: params

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to create a new store" do
    user = users(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    params = {
      store: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    post stores_path, params: params

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to delete a store" do
    user = users(:one)
    store = stores(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    delete store_path(store)

    assert_response :forbidden
  end
end
