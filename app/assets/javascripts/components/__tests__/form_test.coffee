###* @jsx React.DOM ###

jest.dontMock("../form")

React             = require("react/addons")
Test              = React.addons.TestUtils
{Form, FormField} = require("../form")

describe "Form", ->

  describe "Field", ->

    it "renders a container for the label and element", ->
      field = Test.renderIntoDocument(`<FormField label="Email" type="email" value="david@test.com" />`)
      div = Test.findRenderedDOMComponentWithTag(field, "div").getDOMNode()
      expect(div.className).toBe("form__field")

    it "renders a label for the field", ->
      field = Test.renderIntoDocument(`<FormField label="Email" type="email" value="david@test.com" />`)
      label = Test.findRenderedDOMComponentWithTag(field, "label").getDOMNode()
      expect(label.className).toBe("form__label")
      expect(label.innerHTML).toBe("Email")

    it "transfers properties to the field", ->
      field = Test.renderIntoDocument(`<FormField label="Email" type="email" value="david@test.com" />`)
      input = Test.findRenderedDOMComponentWithTag(field, "input").getDOMNode()
      expect(input.className).toBe("form__input")
      expect(input.type).toBe("email")
      expect(input.value).toBe("david@test.com")
