require 'test_helper'

class PaginatorTest < ActiveSupport::TestCase
  class SampleController < ActionController::API
    include Paginator

    def response
      @response ||= ActionDispatch::Response.new
    end

    def url_for_page(page, per_page)
      ''
    end
  end

  test '#paginate calls paginate on supplied resource' do
    resource = mock()
    resource.expects(:paginate).returns(collection_stub)
    controller.paginate(resource)
  end

  test '#paginate uses supplied params when present' do
    resource = mock()
    expect_paginate resource, with: has_entries(page: 3, per_page: 10)
    controller(page: 3, per_page: 10).paginate(resource)
  end

  test 'page parameter defaults to 1' do
    resource = mock()
    expect_paginate resource, with: has_entries(page: 1)
    controller.paginate(resource)
  end

  test 'page parameter cannot be less than 1' do
    resource = mock()
    expect_paginate resource, with: has_entries(page: 1)
    controller(page: 0).paginate(resource)
  end

  test 'per_page parameter defaults to WillPaginate.per_page' do
    resource = mock()
    expect_paginate resource, with: has_entries(per_page: WillPaginate.per_page)
    controller.paginate(resource)
  end

  test 'per_page parameter tops out at #max_per_page' do
    expected_page_size = SampleController.new.max_per_page
    resource = mock()
    expect_paginate resource, with: has_entries(per_page: expected_page_size)
    controller(per_page: expected_page_size + 1).paginate(resource)
  end

  private

  def expect_paginate(collection, with: {}, returns: collection_stub)
    collection.expects(:paginate).with(with).returns(returns)
  end

  def controller(params = {})
    @controller ||= SampleController.new.tap do |klass|
      klass.params = ActionController::Parameters.new(params)
    end
  end

  def collection_stub(first_page: true, last_page: true)
    stub(first_page?: first_page, last_page?: last_page)
  end
end
