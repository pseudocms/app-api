require "test_helper"

class Api::SerializableTest < ActiveSupport::TestCase
  class TestModel
    attr_accessor :id, :name, :description
    include Api::Serializable

    def initialize(attrs = {})
      attrs.each { |attr, value| public_send("#{attr}=", value) }
    end
  end

  class TestModelSerializer < Api::Serializer
    attributes :id, :name, :description
    condensed_attributes :id, :name
  end

  test "uses a custom serializer when available" do
    TestModelSerializer.any_instance.expects(:as_json)
    instance = TestModel.new(id: 0, name: "Some Model")
    instance.as_json
  end

  test "serializes attributes when no options are supplied" do
    expected = { id: 1, name: "Something", description: "JSONey" }
    instance = TestModel.new(expected)
    assert_equal expected.as_json, instance.as_json
  end

  test "serializes condensed_attributes when passed condensed: true" do
    instance = TestModel.new(id: 1, name: "Something", description: "Else")
    expected = { id: 1, name: "Something" }
    assert_equal expected.as_json, instance.as_json(condensed: true)
  end

  test "when serializer not found the call is passed to super" do
    instance = Class.new {
      attr_accessor :id, :name
      include Api::Serializable
    }.new.tap do |obj|
      obj.id = 1
      obj.name = "Some Object"
    end

    instance.as_json
  end
end
