require 'test_helper'

class AccessTokenTest < ActiveSupport::TestCase

  test ".by_token finds the access_token by the token" do
    access_token = create(:access_token)
    assert_equal access_token, AccessToken.by_token(access_token.token)
  end

  test "when not found .by_token returns nil" do
    assert_nothing_raised do
      assert_nil AccessToken.by_token("bogus_token")
    end
  end

  test "a token is revoked when revoked_at is not nil" do
    access_token = build(:access_token, revoked_at: DateTime.now)
    assert access_token.revoked?
  end

  test "a token is expired when expires_in > 0 and it's outside the window" do
    access_token = build(:access_token, expires_in: 1, created_at: DateTime.now - 2.seconds)
    assert access_token.expired?
  end

  test "a token is not expired when expires_in > 0 but we're inside the window" do
    access_token = build(:access_token, expires_in: 5, created_at: DateTime.now)
    refute access_token.expired?
  end

  test "a token is not expired when expires_in == 0" do
    access_token = build(:access_token, created_at: DateTime.now)
    refute access_token.expired?
  end

  test "a token is accessible when not revoked or expired" do
    access_token = build(:access_token, created_at: DateTime.now)
    assert access_token.accessible?
  end

  test "a token is not accessible when revoked" do
    access_token = build(:access_token, revoked_at: DateTime.now)
    refute access_token.accessible?
  end

  test "a token is not accessible when expired" do
    access_token = build(:access_token, expires_in: 1, created_at: DateTime.now - 2.seconds)
    refute access_token.accessible?
  end

  test "calling revoke revokes the access token immediately" do
    access_token = create(:access_token)
    access_token.revoke

    assert access_token.revoked?
    assert access_token.reload.revoked?
  end
end
