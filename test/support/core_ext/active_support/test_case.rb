class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  include FactoryGirl::Syntax::Methods

  def assert_json(model, expect: expect, refute: {}, exclude: [])
    json = model.as_json

    expect.as_json.each { |attr, value| assert_equal value, json[attr] }
    refute.as_json.each { |attr, value| refute_equal value, json[attr] }
    exclude.each { |attr| refute json.has_key?(attr.to_s) }
  end
end
