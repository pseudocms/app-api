module APITest
  extend ActiveSupport::Concern

  module ClassMethods

    def api_version(version)
      define_method :api_version do
        version
      end

      send(:include, APITestHelpers)
    end
  end

  module APITestHelpers

    def post(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
    end

    def get(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
    end

    def default_headers
      { 'HTTP_ACCEPT' => 'vnd.pseudocms.v%s-json' % api_version }
    end

    def authenticate_as(fixture_name)
      user = users(fixture_name)
      app = user.applications.create(name: 'APITest', redirect_uri: 'http://test.com')
      token = Doorkeeper::AccessToken.create!(
        application_id: app.id,
        resource_owner_id: user.id
      )

      ApplicationController.any_instance.stubs(:doorkeeper_token).returns(token)
    end

    def encode_credentials(user, pass)
      ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
    end
  end
end

class ActionDispatch::IntegrationTest
  include APITest
end
