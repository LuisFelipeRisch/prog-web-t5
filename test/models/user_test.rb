require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'Email and password should be required to create a user' do
    user = User.new

    refute user.valid?

    assert_equal [{:error=>:blank}], user.errors.details[:email]
    assert_equal [{:error=>:blank}], user.errors.details[:password]
  end

  test 'Password should has at least 6 chars' do
    user = User.new(password: '123')

    refute user.valid?

    assert_equal [{:error=>:too_short, :count=>6}], user.errors.details[:password]

    user.password = '123456'

    user.valid?

    assert_not_equal [{:error=>:too_short, :count=>6}], user.errors.details[:password]
  end

  test 'Password and password confirmation should be equal' do
    user = User.new(password: '123456', password_confirmation: '1234567')

    refute user.valid?

    assert_equal [{:error=>:confirmation, :attribute=>"Password"}], user.errors.details[:password_confirmation]

    user.password_confirmation = user.password

    user.valid?

    assert_not_equal [{:error=>:confirmation, :attribute=>"Password"}], user.errors.details[:password_confirmation]
  end

  test 'Cart should be initialized when creating a user' do
    user = User.new(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')

    assert_difference 'Cart.count', 1 do
      user.save!
    end

    assert_equal Cart.last, user.cart
  end

  test 'Cart should be destroyed when user is destroyed' do
    user = User.new(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')

    assert_difference 'Cart.count', 1 do
      user.save!
    end

    assert_equal Cart.last, user.cart

    assert_difference 'Cart.count', -1 do
      user.destroy
    end
  end
end
