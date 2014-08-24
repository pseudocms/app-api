require "support/api_test"
require "support/pagination_test"

class ActionDispatch::IntegrationTest
  include APITest
  include PaginationTest
end
