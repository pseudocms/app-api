require 'test_helper'

class AuthorizableTest < ActiveSupport::TestCase

  class SampleController < ApplicationController
    allow(:update) { account_owner? || blessed_app? }

    def update
      head 200
    end
  end

  test '#current_user is nil without doorkeeper_token' do
    assert_nil controller(doorkeeper_token: nil).current_user
  end

  test '#current_user is nil when token has no owner (app)' do
    overrides = {
      doorkeeper_token: stub(
        application: oauth_applications(:normal_app),
        resource_owner_id: nil
      )
    }

    assert_nil controller(overrides).current_user
  end

  test '#current_user is the token owner when doorkeeper_token' do
    user = users(:david)
    overrides = { doorkeeper_token: stub(resource_owner_id: user.id) }
    assert_equal user, controller(overrides).current_user
  end

  test '#current_application is nil without doorkeeper_token' do
    assert_nil controller(doorkeeper_token: nil).current_application
  end

  test '#current_application is the owning application when doorkeeper_token' do
    app = oauth_applications(:normal_app)
    overrides = { doorkeeper_token: stub(application: app) }
    assert_equal app, controller(overrides).current_application
  end

  test '#blessed_app? is false when current_application is nil' do
    refute controller(doorkeeper_token: nil).blessed_app?
  end

  test '#blessed_app? is false when current_application is not blessed' do
    app = oauth_applications(:normal_app)
    overrides = { doorkeeper_token: stub(application: app) }
    refute controller(overrides).blessed_app?
  end

  test '#blessed_app? is true when current_application is blessed' do
    app = oauth_applications(:blessed_app)
    overrides = { doorkeeper_token: stub(application: app) }
    assert controller(overrides).blessed_app?
  end

  private

  def controller(stubs = {})
    @subject ||= SampleController.new.tap do |klass|
      klass.stubs(stubs)
    end
  end
end
