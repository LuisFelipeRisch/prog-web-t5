require "test_helper"

class CartProductTest < ActiveSupport::TestCase
  EPSILON = 0.0005

  test 'should cart and product required' do
    cart_product = CartProduct.new
    refute cart_product.valid?

    assert_equal cart_product.errors.messages[:cart], ["must exist"]
    assert_equal cart_product.errors.messages[:product], ["must exist"]
  end

  test 'should product total value be set before creation' do
    cart = Cart.new
    product = Product.new(total_value: 1.0)

    cart.save!(validate: false)
    product.save!(validate: false)

    cart_product = CartProduct.new(cart: cart, product: product)
    cart_product.save!(validate: false)

    assert_in_epsilon cart_product.total_value, 1.0, EPSILON
  end
end
