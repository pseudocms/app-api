require 'test_helper'

class TokenAccessibleTest < ActiveSupport::TestCase

  test '#current_resource_owner is nil without doorkeeper_token' do
    assert_nil subject.current_resource_owner
  end

  test '#current_resource_owner is the token owner when doorkeeper_token' do
    user = users(:david)
    token = stub(resource_owner_id: user.id)
    assert_equal user, subject(token).current_resource_owner
  end

  test '#current_application is nil without doorkeeper_token' do
    assert_nil subject.current_application
  end

  test '#current_application is the owning application when doorkeeper_token' do
    app_object = stub(name: 'Expected Application')
    token = stub(application: app_object)
    assert_equal app_object, subject(token).current_application
  end

  private

  def subject(token = nil)
    @subject ||= ApplicationController.new.tap do |klass|
      klass.stubs(doorkeeper_token: token)
    end
  end
end
