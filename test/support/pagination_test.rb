module PaginationTest
  extend ActiveSupport::Concern

  module ClassMethods
    def pagination_test(setup_method)
      define_method :pagination_setup do |page, per_page|
        send(setup_method, page, per_page)
      end

      send(:include, PaginationTest::TestModule)
    end
  end

  module TestModule

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
end
