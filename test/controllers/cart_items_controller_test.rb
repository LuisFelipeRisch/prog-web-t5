require "test_helper"

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "User should be redirected to login page if tries to insert a product to cart" do
    params = {
      productId: products(:one).id
    }

    post cart_items_path, params: params

    assert_redirected_to new_user_session_path
  end

  test "Logged in user should be possible to inser product to your cart" do
    user = users(:one)

    user.build_cart

    user.save!(validate: false)

    sign_in(user)

    params = {
      productId: products(:one).id
    }

    assert_difference 'user.cart.cart_products.count', 1 do
      post cart_items_path, params: params
    end
  end
end
