require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase

  test "name is required" do
    app = build(:application, name: "")
    refute app.valid?
    assert_sole_error app, :name
  end

  test "name must be unique" do
    app1 = create(:application)
    app2 = build(:application, name: app1.name)

    refute app2.save
    assert_sole_error app2, :name
  end

  test "client_id and client_secret are generated before validation" do
    app = build(:application, client_id: nil, client_secret: nil)
    assert app.valid?
  end

  private

  def assert_sole_error(model, attr)
    assert_equal 1, model.errors.size
    assert model.errors.has_key?(attr)
  end
end
