require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test 'should validate name and total value and store' do
    product = Product.new
    refute product.valid?

    assert_equal product.errors.messages[:name], ["can't be blank"]
    assert_equal product.errors.messages[:total_value], ["can't be blank"]
    assert_equal product.errors.messages[:store], ["must exist"]

    store = Store.new
    store.save!(validate: false)

    product.name = "Dummy product"
    product.total_value = 10.0
    product.store = store

    assert product.valid?
  end

  test 'should delete cart products when product is deleted' do
    product = Product.new
    product.save!(validate: false)

    cart = Cart.new
    cart.add_product(product: product)
    cart.save!(validate: false)

    product.destroy

    refute CartProduct.exists?(product: product)
  end
end
