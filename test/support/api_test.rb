module APITest
  extend ActiveSupport::Concern

  module ClassMethods

    def api_version(version)
      define_method :api_version do
        version
      end

      send(:include, APITest::TestHelpers)
      send(:include, APITest::TestModule)
    end
  end

  module TestModule

    def assert_request_id_header
      assert response.headers.has_key?("X-Request-Id")
      assert_match /\w{8}\-(\w{4}\-){3}\w{12}/, response.headers["X-Request-Id"]
    end
  end

  module TestHelpers

    def post(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
      assert_request_id_header
    end

    def get(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
      assert_request_id_header
    end

    def patch(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
      assert_request_id_header
    end

    def delete(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
      assert_request_id_header
    end

    private

    def default_headers
      @default_headers ||= {
        'HTTP_ACCEPT' => 'vnd.pseudocms.v%s-json' % api_version
      }
    end

    def user_auth(user_name, blessed: false, scopes: [])
      user = create(:user, email: "#{user_name}@pseudocms.com")
      app = create(:app, blessed: blessed)

      token = Doorkeeper::AccessToken.create!(
        application_id: app.id,
        resource_owner_id: user.id,
        scopes: scopes.join(",")
      )

      default_headers["HTTP_AUTHORIZATION"] = "Bearer #{token.token}"
      user
    end

    def client_auth(blessed: false)
      app = create(:app, blessed: blessed)
      token = Doorkeeper::AccessToken.create!(application_id: app.id)

      default_headers["HTTP_AUTHORIZATION"] = "Bearer #{token.token}"
      app
    end

    def encode_credentials(user, pass)
      ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
    end
  end
end
