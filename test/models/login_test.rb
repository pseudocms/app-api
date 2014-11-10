require "test_helper"

class LoginTest < ActiveSupport::TestCase

  test "sets instance variables when supplied to initializer" do
    login = Login.new(email: "david@test.com", password: "12345", application: application)
    assert_equal "david@test.com", login.email
    assert_equal "12345", login.password
  end

  test "email is required" do
    login = Login.new(password: "12345", application: application)
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
      login = Login.new(email: email, password: "12345", application: application)
      refute login.valid?, "'#{email}' should not be valid"
    end
  end

  test "password is required" do
    login = Login.new(email: "david@test.com", application: application)
    refute login.valid?
    assert_equal 1, login.errors.size
    assert login.errors.has_key?(:password)
  end

  test "application is required" do
    login = Login.new(email: "david@test.com", password: "somePassword")
    refute login.valid?
    assert_equal 1, login.errors.size
    assert login.errors.has_key?(:application)
  end

  test "#find_or_create_token creates a token" do
    user = create(:user, password: "somePassword")
    login = Login.new(email: user.email, password: "somePassword", application: application)

    assert_difference "user.access_tokens.count" do
      assert_not_nil login.find_or_create_token
    end
  end

  test "#find_or_create_token uses existing token when accessible" do
    user = create(:user, password: "somePassword")
    login = Login.new(email: user.email, password: "somePassword", application: application)

    assert_not_nil login.find_or_create_token

    assert_no_difference "user.access_tokens.count" do
      assert_not_nil login.find_or_create_token
    end
  end

  test "#find_or_create_token creates a new token when not accessible" do
    user = create(:user, password: "somePassword")
    login = Login.new(email: user.email, password: "somePassword", application: application)

    token = login.find_or_create_token
    token.update_attributes(revoked_at: DateTime.now)

    assert_difference "user.access_tokens.count" do
      assert_not_nil login.find_or_create_token
    end
  end

  test "#find_or_create_token returns nil with invalid credentials" do
    user = create(:user, password: "somePassword")
    login = Login.new(email: user.email, password: "NotsomePassword", application: application)

    assert_nil login.find_or_create_token
  end

  private

  def application
    @application || create(:application)
  end
end
