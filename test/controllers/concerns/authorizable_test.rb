require 'test_helper'

class AuthorizableTest < ActionController::TestCase

  class SampleController < ActionController::API
    include Authorizable

    allow(:index) { account_owner? || blessed_app? }
    deny(:new)    { !blessed_app? }

    def index
      head :ok
    end

    def new
      head :ok
    end

    def render_denied
      head :forbidden
    end
  end

  setup do
    Rails.application.routes.draw do
      namespace :authorizable_test do
        controller :sample do
          get 'index'
          get 'new'
        end
      end
    end
  end

  teardown do
    Rails.application.reload_routes!
  end

  test '.allow allows access if block returns true' do
    @controller = controller(account_owner?: true)
    get :index
    assert_response 200
  end

  test '.allow denies access if block returns false' do
    @controller = controller(account_owner?: false, blessed_app?: false)
    get :index
    assert_response 403
  end

  test '.deny denies access if the block returns true' do
    @controller = controller(blessed_app?: false)
    get :new
    assert_response 403
  end

  test '.deny allows access when the block returns false' do
    @controller = controller(blessed_app?: true)
    get :new
    assert_response 200
  end

  test '#current_user is nil without doorkeeper_token' do
    assert_nil controller(doorkeeper_token: nil).current_user
  end

  test '#current_user is nil when token has no owner (app)' do
    overrides = {
      doorkeeper_token: stub(
        application: create(:app),
        resource_owner_id: nil
      )
    }

    assert_nil controller(overrides).current_user
  end

  test '#current_user is the token owner when doorkeeper_token' do
    user = create(:user)
    overrides = { doorkeeper_token: stub(resource_owner_id: user.id) }
    assert_equal user, controller(overrides).current_user
  end

  test '#current_application is nil without doorkeeper_token' do
    assert_nil controller(doorkeeper_token: nil).current_application
  end

  test '#current_application is the owning application when doorkeeper_token' do
    app = create(:app)
    overrides = { doorkeeper_token: stub(application: app) }
    assert_equal app, controller(overrides).current_application
  end

  test '#blessed_app? is false when current_application is nil' do
    refute controller(doorkeeper_token: nil).blessed_app?
  end

  test '#blessed_app? is false when current_application is not blessed' do
    app = create(:app)
    overrides = { doorkeeper_token: stub(application: app) }
    refute controller(overrides).blessed_app?
  end

  test '#blessed_app? is true when current_application is blessed' do
    app = create(:blessed_app)
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
