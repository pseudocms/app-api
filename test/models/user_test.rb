require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'auth_token is generated on save' do
    user = User.new(email: 'some@user.com', password: 'i13uy6h89')
    user.save!

    refute user.auth_token.blank?
  end

  test 'reset_auth_token generates a new token and saves the user' do
    user = users(:david)
    user.save!

    token = user.auth_token.dup
    user.reset_auth_token

    refute_equal token, user.reload.auth_token
  end
end
