require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "email must be unique" do
    user = create(:user)
    new_user = User.new(email: user.email, password: "somePassword")

    refute new_user.save
    assert_equal 1, new_user.errors.size
    assert new_user.errors.has_key?(:email)
  end

  test "password is required" do
    user = User.new(email: "test@user.com", password: "")
    refute user.valid?
    assert_equal 1, user.errors.size
    assert user.errors.has_key?(:password)
  end

  test "api serialization is legit" do
    user = create(:user)
    user_attrs = [:id, :email, :created_at, :updated_at]
    expected = user.attributes.select { |attr, _| user_attrs.include?(attr) }

    assert_json(user, expect: expected, exclude: [:password])
  end
end
