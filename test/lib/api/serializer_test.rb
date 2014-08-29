require "test_helper"

class Api::SerializerTest < ActiveSupport::TestCase

  class BaseModel
    attr_accessor :id
    include Api::Serializable

    def initialize(attrs = {})
      attrs.each { |attr, value| send("#{attr}=", value) }
    end
  end

  class TopModel < BaseModel
    attr_accessor :name
  end

  class TestModel < BaseModel
    attr_accessor :name, :password, :parent
  end

  class TopModelSerializer < Api::Serializer
    attributes :id, :name
  end

  class TestModelSerializer < Api::Serializer
    attributes :id, :name
    belongs_to :parent
  end

  test ".for returns a serializer instance specific to the type" do
    serializer = Api::Serializer.for(TestModel.new)
    assert_kind_of TestModelSerializer, serializer
  end

  test ".for returns nil when no custom serializer is found" do
    serializer = Api::Serializer.for(BaseModel.new)
    assert_nil serializer
  end

  test "serializing includes named attributes from custom serializer" do
    object = TestModel.new(id: 1, name: "test_name")
    json = Api::Serializer.for(object).as_json
    assert_equal 1, json["id"]
    assert_equal "test_name", json["name"]
  end

  test "serializing excludes attributes that aren't named in custom serializer" do
    object = TestModel.new(id: 1, name: "test_name", password: "Some Value")
    json = Api::Serializer.for(object).as_json
    refute json.has_key?("password")
  end

  test "serializing belongs_to by default only serializes the parent's id" do
    parent = TopModel.new(id: 2, name: "Parent")
    object = TestModel.new(id: 1, name: "test_name", parent: parent)
    json = Api::Serializer.for(object).as_json

    expected = { id: parent.id }.as_json
    assert_equal expected, json["parent"]
  end

  test "serializing belongs_to with expanded: true, embeds the serialized parent" do
    TestModelSerializer.stubs(_associations: { parent: { expanded: true } })
    parent = TopModel.new(id: 2, name: "Parent")
    object = TestModel.new(id: 1, name: "test_name", parent: parent)
    json = Api::Serializer.for(object).as_json
    assert_equal parent.as_json, json["parent"]
  end

  test "serializing belongs_to with a nil parent sets it to nil" do
    object = TestModel.new(id: 1, name: "test_name")
    json = Api::Serializer.for(object).as_json
    assert json.has_key?("parent")
    assert_nil json["parent"]
  end
end
