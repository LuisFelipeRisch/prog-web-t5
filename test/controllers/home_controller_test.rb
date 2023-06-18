require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Product.destroy_all #skip validation
  end

  test 'Logged user can access root' do
    user = users(:one)

    user.build_cart

    user.save!(validate: false)

    sign_in(user)

    get root_path

    assert_response :success
  end

  test 'not logged user can access root' do
    get root_path

    assert_response :success
  end
end
