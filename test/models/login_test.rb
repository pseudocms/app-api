require "test_helper"

class LoginTest < ActiveSupport::TestCase

  test "sets instance variables when supplied to initializer" do
    login = Login.new(email: "david@test.com", password: "12345")
    assert_equal "david@test.com", login.email
    assert_equal "12345", login.password
  end

  test "email is required" do
    login = Login.new(password: "12345")
    refute login.valid?
    assert_equal 1, login.errors.size
    assert login.errors.has_key?(:email)
  end

  test "email must be a valid email address" do
    invalidEmails = [
      nil,
      "",
      "something",
      "david\"s@email.com",
      "symbols(are@not.allowed"
    ]

    invalidEmails.each do |email|
      login = Login.new(email: email, password: "12345")
      refute login.valid?, "'#{email}' should not be valid"
    end
  end

  test "password is required" do
    login = Login.new(email: "david@test.com")
    refute login.valid?
    assert_equal 1, login.errors.size
    assert login.errors.has_key?(:password)
  end
end
