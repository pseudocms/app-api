###* @jsx React.DOM ###

jest.dontMock("../input")

describe "Input", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "renders an input tag with the supplied props", ->
    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" value="value" />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()
    expect(node.name).toBe("item")
    expect(node.value).toBe("value")

  it "initially doesn't validate when value is not supplied", ->
    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" value="" />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()
    expect(node.className).toBe("")

  it "starts validating after the value has been supplied", ->
    jest.setMock "lodash",
      debounce: (fn, time) ->
        -> fn()

    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" value="" valid={true} />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()
    expect(node.className).toBe("")

    @utils.Simulate.change(node, { value: "myValue" })
    expect(node.className).toBe("valid")

  it "calls the supplied onChange event when supplied", ->
    jest.setMock "lodash",
      debounce: (fn, time) ->
        -> fn()

    onChange = jest.genMockFn()

    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" onChange={onChange} />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()

    @utils.Simulate.change(node)
    expect(onChange).toBeCalled()

  it "sets class name correctly when valid is true", ->
    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" value="myValue" valid={true} />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()
    expect(node.className).toBe("valid")

  it "sets class name correctly when valid is false", ->
    Input = require("../input")
    input = @utils.renderIntoDocument(`<Input name="item" value="myValue" valid={false} />`)
    node = @utils.findRenderedDOMComponentWithTag(input, "input").getDOMNode()
    expect(node.className).toBe("invalid")
