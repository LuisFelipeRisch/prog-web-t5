require "test_helper"

class CartTest < ActiveSupport::TestCase
  EPSILON = 0.0005

  test 'should user be required on cart creation' do
    cart = Cart.new
    refute cart.valid?

    assert_equal cart.errors.messages[:user], ['must exist']
  end

  test 'should be possible to add products to cart' do
    cart = Cart.new
    cart.save!(validate: false)

    product = Product.new(name: 'Dummy Name', description: 'Dummy Description', total_value: 10.0)
    product.save!(validate: false)

    cart.add_product(product: product)
    cart.save!(validate: false)

    assert cart.products.exists?(id: product.id)
  end

  test 'should delete cart products relation when cart is deleted but should not delete product' do
    cart = Cart.new
    cart.save!(validate: false)

    product = Product.new
    product.save!(validate: false)
    cart.add_product(product: product)

    count_before = CartProduct.where(cart: cart).count
    cart.save!(validate: false)
    count_after = CartProduct.where(cart: cart).count

    assert_equal count_after - count_before, 1

    cart.destroy

    refute CartProduct.exists?(cart: cart)
    assert Product.exists?(id: product.id)
  end

  test 'should not be possible to change total value of a product inserted in cart' do
    cart = Cart.new
    cart.save!(validate: false)

    product = Product.new(total_value: 10.0)
    product.save!(validate: false)

    cart.add_product(product: product)
    cart.save!(validate: false)

    assert cart.products.exists?(id: product.id)
    assert_in_epsilon cart.cart_products.last.total_value, 10.0, EPSILON

    product.total_value = 20.0
    product.save!(validate: false)
    assert_in_epsilon cart.cart_products.last.total_value, 10.0, EPSILON
  end

  test 'should raise exception if type mismatch' do
    cart = Cart.new
    cart.save!(validate: false)

    assert_raises ActiveRecord::AssociationTypeMismatch do
      cart.add_product(product: 'fake product')
    end
  end
end
