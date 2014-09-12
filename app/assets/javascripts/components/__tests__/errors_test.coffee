###* @jsx React.DOM ###

jest.dontMock("../errors")

describe "Errors", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "renders a container div with the right class name", ->
    Errors = require("../errors")
    errors = @utils.renderIntoDocument(`<Errors message="My Message" errors={["hey"]} />`)
    node = @utils.findRenderedDOMComponentWithTag(errors, "div").getDOMNode()
    expect(node.className).toBe("form__errors")

  it "renders the message inside the container", ->
    Errors = require("../errors")
    errors = @utils.renderIntoDocument(`<Errors message="My Message" errors={["hey"]} />`)
    node = @utils.findRenderedDOMComponentWithTag(errors, "h1").getDOMNode()
    expect(node.innerHTML).toBe("My Message")

  it "skips the message when null or empty", ->
    Errors = require("../errors")
    errors = @utils.renderIntoDocument(`<Errors message="" errors={["error"]} />`)
    nodes = @utils.scryRenderedDOMComponentsWithTag(errors, "h1")
    expect(nodes.length).toBe(0)

  it "renders error messages as list items", ->
    Errors = require("../errors")
    errors = @utils.renderIntoDocument(`<Errors message="My Message" errors={["hey", "there"]} />`)
    nodes = @utils.scryRenderedDOMComponentsWithTag(errors, "li")
    expect(nodes.length).toBe(2)
    expect(nodes[0].getDOMNode().innerHTML).toBe("hey")
    expect(nodes[1].getDOMNode().innerHTML).toBe("there")

  it "doesn't render anything when errors is null or empty", ->
    Errors = require("../errors")
    errors = @utils.renderIntoDocument(`<Errors message="My Message" errors={[]} />`)
    node = @utils.scryRenderedDOMComponentsWithTag(errors, "div")
    expect(node.length).toBe(0)
