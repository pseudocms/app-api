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

  test 'auth_token is generated on save' do
    user = User.new(email: 'some@user.com', password: 'i13uy6h89')
    user.save!

    refute user.auth_token.blank?
  end

  test 'reset_auth_token generates a new token and saves the user' do
    user = users(:david)

    token = user.auth_token.dup
    user.reset_auth_token

    refute_equal token, user.reload.auth_token
  end
end
