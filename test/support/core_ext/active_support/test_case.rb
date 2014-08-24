class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  include FactoryGirl::Syntax::Methods
end
