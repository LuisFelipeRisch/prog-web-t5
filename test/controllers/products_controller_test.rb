require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "User should be redirected to log in page if enter in new product, without being logged in" do
    get new_product_path

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if enter in edit product, without being logged in" do
    product = products(:one)

    get edit_product_path(product)

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to edit product, without being logged in" do
    product = products(:one)

    params = {
      product: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    patch product_path(product), params: params

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to create new product, without being logged in" do
    params = {
      product: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    post products_path, params: params

    assert_redirected_to new_user_session_path
  end

  test "User should be redirected to log in page if try to delete a product, without being logged in" do
    product = products(:one)

    delete product_path(product)

    assert_redirected_to new_user_session_path
  end

  test "Should render forbidden page if user is not admin and tries to enter in the new page" do
    user = users(:one)
    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    get new_product_path

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to enter in the edit page" do
    user = users(:one)
    product = products(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    get edit_product_path(product)

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to enter in the edit a product" do
    user = users(:one)
    product = products(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    params = {
      product: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    patch product_path(product), params: params

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to create a new product" do
    user = users(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    params = {
      product: {
        name: 'Test name',
        description: 'Test description'
      }
    }

    post products_path, params: params

    assert_response :forbidden
  end

  test "Should render forbidden page if user is not admin and tries to delete a product" do
    user = users(:one)
    product = products(:one)

    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    delete product_path(product)

    assert_response :forbidden
  end

  test "Admin user can create a new product" do
    user = users(:one)

    user.is_admin = true
    user.build_cart
    user.save!(validate: false)

    sign_in(user)

    params = {
      product: {
        name: 'Test name',
        description: 'Test description',
        total_value: 40.5,
        store_id: stores(:one).id
      }
    }

    assert_difference 'Product.count', 1 do
      post products_path, params: params
    end
  end
end
