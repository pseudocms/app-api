require 'test_helper'

class PaginatorTest < ActiveSupport::TestCase
  class SampleController < ActionController::API
    include Paginator
  end

  test '#paginate calls paginate on supplied resource' do
    resource = mock()
    resource.expects(:paginate)
    controller.paginate(resource)
  end

  test '#paginate uses supplied params when present' do
    resource = mock()
    resource.expects(:paginate).with(has_entries(page: 3, per_page: 10))
    controller(page: 3, per_page: 10).paginate(resource)
  end

  test 'page parameter defaults to 1' do
    resource = mock()
    resource.expects(:paginate).with(has_entries(page: 1))
    controller.paginate(resource)
  end

  test 'page parameter cannot be less than 1' do
    resource = mock()
    resource.expects(:paginate).with(has_entries(page: 1))
    controller(page: 0).paginate(resource)
  end

  test 'per_page parameter defaults to WillPaginate.per_page' do
    resource = mock()
    resource.expects(:paginate).with(has_entries(per_page: WillPaginate.per_page))
    controller.paginate(resource)
  end

  private

  def controller(params = {})
    @controller ||= SampleController.new.tap do |klass|
      klass.params = ActionController::Parameters.new(params)
    end
  end
end
