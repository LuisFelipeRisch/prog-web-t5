require "test_helper"

class CartProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)

    @cart = @user.build_cart

    @cart_product = @cart.add_product(product: products(:one))

    @cart.save!(validate: false)
  end

  test "Should not be possible to delete CartProduct without be logged in" do
    delete remove_cart_product_path(@cart_product)

    assert_redirected_to new_user_session_path
  end

  test "Should render forbidden page if logged user try to delete other cart product" do
    user_two = users(:two)

    user_two.build_cart

    user_two.save!(validate: false)

    sign_in(user_two)

    delete remove_cart_product_path(@cart_product)

    assert_response :forbidden
  end

  test 'Should be possible to user delete your cart product' do
    sign_in(@user)

    assert_difference 'CartProduct.count', -1 do
      delete remove_cart_product_path(@cart_product)
    end
  end
end
