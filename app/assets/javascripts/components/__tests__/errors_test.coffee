###* @jsx React.DOM ###

jest.dontMock("../errors")

React  = require("react/addons")
Test   = React.addons.TestUtils
Errors = require("../errors")

describe "Errors", ->

  it "renders a box to contain the errors", ->
    errors = Test.renderIntoDocument(`<Errors />`)
    container = Test.findRenderedDOMComponentWithTag(errors, "div").getDOMNode()
    expect(container.className).toBe("box box--errors")

  it "renders the title", ->
    errors = Test.renderIntoDocument(`<Errors title="Errors huh?" />`)
    title = Test.findRenderedDOMComponentWithTag(errors, "h1").getDOMNode()
    expect(title.innerHTML).toBe("Errors huh?")

  it "renders the messages", ->
    errors = Test.renderIntoDocument(`<Errors messages={["Message 1", "Message 2"]} />`)
    messages = Test.scryRenderedDOMComponentsWithTag(errors, "li")
    expect(messages.length).toBe(2)
    expect(messages[0].getDOMNode().innerHTML).toBe("Message 1")
    expect(messages[1].getDOMNode().innerHTML).toBe("Message 2")
