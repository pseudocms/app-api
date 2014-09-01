require "support/api_test"
require "support/pagination_test"

class ActionDispatch::IntegrationTest
  include APITest
  include PaginationTest

  setup do
    https!
  end

  def assert_successful_update
    assert_response :no_content
    assert response.body.blank?
  end
  alias_method :assert_successful_delete, :assert_successful_update

  def assert_permission_denied
    assert_error(:forbidden, message: "Permission denied")
  end

  def assert_not_found(message = nil)
    message ||= "#{model_under_test} not found"
    assert_error(:not_found, message: message)
  end

  def assert_error(status, message: message, no_body: false)
    assert_response status
    if no_body
      assert_not_nil api_response["errors"]
    else
      assert_equal Rack::Utils::SYMBOL_TO_STATUS_CODE[status], api_response["errors"]["status"]
      assert_equal message, api_response["errors"]["message"] if message
    end
  end

  def api_response
    @api_response ||= JSON.parse(response.body)
  end

  private

  def model_under_test
    @modal_under_test ||= begin
      self.class.name.demodulize.underscore.split(/_/).first.humanize.singularize
    end
  end
end
