require "test_helper"

class StoreTest < ActiveSupport::TestCase
  test 'should validate store name' do
    store = Store.new
    refute store.valid?

    assert_equal store.errors.messages[:name], ["can't be blank"]

    store.name = 'Dummy'
    assert store.valid?
  end

  test 'should create store' do
    store = Store.new(name: 'Dummy name', description: 'Dummy description')
    store.save!(validate: false)

    assert_equal 'Dummy name', store.name
    assert_equal 'Dummy description', store.description
  end

  test 'should associate products to store' do
    store = Store.new
    store.save!(validate: false)

    store.add_product({name: 'Dummy product name', description: 'Dummy product description', total_value: 10.0})
    store.save!(validate: false)

    assert store.products.exists?(id: Product.last.id)
  end

  test 'should raise exception if tries to pass unknow product attr' do
    store = Store.new
    store.save!(validate: false)

    assert_raises ActiveModel::UnknownAttributeError do
      store.add_product({unknow_attr: 'unknow'})
    end
  end

  test 'should delete all products when store is deleted' do
    store = Store.new
    store.save!(validate: false)

    product = store.add_product({name: 'Dummy product name', description: 'Dummy product description', total_value: 10.0})
    store.save!(validate: false)

    assert store.products.exists?(id: product.id)

    store.destroy

    refute Product.exists?(store: store)
  end
end
