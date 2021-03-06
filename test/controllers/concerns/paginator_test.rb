require 'test_helper'

class PaginatorTest < ActiveSupport::TestCase
  class SampleController < ActionController::API
    include Paginator

    def response
      @response ||= ActionDispatch::Response.new
    end
  end

  test '#paginate calls paginate on supplied resource' do
    resource = mock()
    expect_paginate(resource)
    controller.paginate(resource)
  end

  test '#paginate uses supplied params when present' do
    resource = mock()
    expect_paginate(resource, page: 3, per_page: 10)
    controller(page: 3, per_page: 10).paginate(resource)
  end

  test 'page parameter defaults to 1' do
    resource = mock()
    expect_paginate(resource, page: 1)
    controller.paginate(resource)
  end

  test 'page parameter cannot be less than 1' do
    resource = mock()
    expect_paginate(resource, page: 1)
    controller(page: 0).paginate(resource)
  end

  test 'per_page parameter defaults to WillPaginate.per_page' do
    resource = mock()
    expect_paginate(resource, per_page: Paginator::PAGINATOR_DEFAULTS[:per_page])
    controller.paginate(resource)
  end

  test 'per_page parameter tops out at #max_per_page' do
    expected_page_size = SampleController.new.max_per_page
    resource = mock()
    expect_paginate(resource, per_page: expected_page_size)
    controller(per_page: expected_page_size + 1).paginate(resource)
  end

  private

  def expect_paginate(collection, page: page, per_page: per_page)
    page ||=  Paginator::PAGINATOR_DEFAULTS[:page]
    per_page ||= Paginator::PAGINATOR_DEFAULTS[:per_page]

    result = collection_stub
    result.expects(:per).returns(result)
    collection.expects(:page).with(page).returns(result)
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
