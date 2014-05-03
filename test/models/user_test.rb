require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'email must be unique' do
    user = users(:david)
    new_user = User.new(email: user.email, password: 'somePassword')

    refute new_user.save
    assert_equal 1, new_user.errors.size
    assert new_user.errors.has_key?(:email)
  end

  test 'password is required' do
    user = User.new(email: 'test@user.com', password: '')
    refute user.valid?
    assert_equal 1, user.errors.size
    assert user.errors.has_key?(:password)
  end
end
