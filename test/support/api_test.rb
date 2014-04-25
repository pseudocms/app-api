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
      default_headers = { 'HTTP_ACCEPT' => 'vnd.pseudocms.v%s+json' % api_version }
      super(uri, params, default_headers.merge(headers))
    end

    def encode_credentials(user, pass)
      ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
    end
  end
end

class ActionDispatch::IntegrationTest
  include APITest
end
