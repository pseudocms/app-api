require 'test_helper'

class ApiConstraintsTest < ActiveSupport::TestCase

  test '#matches? returns true when the constraint is default' do
    constraint = ApiConstraints.new('1', default: true)
    request = request_with_headers('Accept' => 'vnd.pseudocms.v30059879+json')

    assert constraint.matches?(request)
  end

  test '#matches? returns true when the header is a match' do
    constraint = ApiConstraints.new('1')
    request = request_with_headers('Accept' => 'vnd.pseudocms.v1+json')

    assert constraint.matches?(request)
  end

  test '#matches? returns false when the header is not a match' do
    constraint = ApiConstraints.new('1')
    request = request_with_headers('Accept' => 'vnd.pseudocms.v2+json')

    refute constraint.matches?(request)
  end

  private

  def request_with_headers(headers)
    OpenStruct.new(headers: headers)
  end
end
