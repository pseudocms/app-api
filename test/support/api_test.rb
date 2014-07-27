module APITest
  extend ActiveSupport::Concern

  module ClassMethods

    def api_version(version)
      define_method :api_version do
        version
      end

      send(:include, APITestHelpers)
    end

    def pagination_test(setup_method)
      define_method :pagination_setup do |page, per_page|
        send(setup_method, page, per_page)
      end

      send(:include, PagingTestHelpers)
    end
  end

  module PagingTestHelpers
    def test_pagination_for_first_page
      pagination_setup(1, 1)
      assert_response :ok

      refute page_links.has_key?(:first)
      refute page_links.has_key?(:prev)
      assert page_links.has_key?(:next)
      assert page_links.has_key?(:last)
    end

    def test_pagination_for_middle_page
      pagination_setup(2, 1)
      assert_response :ok

      assert page_links.has_key?(:first)
      assert page_links.has_key?(:prev)
      assert page_links.has_key?(:next)
      assert page_links.has_key?(:last)
    end

    def test_pagination_for_last_page
      last_page = last_page_number
      pagination_setup(last_page, 1)
      assert_response :ok

      assert page_links.has_key?(:first)
      assert page_links.has_key?(:prev)
      refute page_links.has_key?(:next)
      refute page_links.has_key?(:last)
    end

    private

    LINK_HEADER_PATTERN = /\A<([^>]+)>;\s*rel="(.*)"\z/

    def page_links
      @page_links ||= begin
        headers = response.headers['Link'].split(',').map(&:strip)
        {}.tap do |links|
          headers.each do |header|
            if LINK_HEADER_PATTERN =~ header
              links[$2] = $1
            end
          end

          links.symbolize_keys!
        end
      end
    end

    def last_page_number
      last_page = 0

      ActiveRecord::Base.transaction do
        pagination_setup(1, 1)
        last_page = page_links[:last][/page=(\d+)/][$1]
        raise ActiveRecord::Rollback, "rolling it back"
      end

      @page_links = nil
      last_page
    end
  end

  module APITestHelpers

    def post(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
    end

    def get(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
    end

    def patch(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
    end

    def delete(uri, params = {}, headers = {})
      super(uri, params, default_headers.merge(headers))
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

    def json_response
      @json_response ||= JSON.parse(response.body)
    end
  end
end

class ActionDispatch::IntegrationTest
  include APITest
end
