require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Should not be possible to enter in index page of cart without be logged in" do
    get cart_path(1)

    assert_redirected_to new_user_session_path
  end

  test "Should render forbidden page if logged user try to see others cart" do
    user     = users(:one)
    user_two = users(:two)

    cart     = user.build_cart
    cart_two = user_two.build_cart

    cart.save!(validate: false)
    cart_two.save!(validate: false)

    sign_in(user)

    get cart_path(cart_two)

    assert_response :forbidden
  end

  test "User can only see your cart" do
    user = users(:one)

    cart = user.build_cart

    cart.save!(validate: false)

    sign_in(user)

    get cart_path(cart)

    assert_response :success
  end
end
