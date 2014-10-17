###* @jsx React.DOM ###

jest.dontMock("../heading")

React   = require("react/addons")
Test    = React.addons.TestUtils
Heading = require("../heading")

describe "Heading", ->

  it "renders a heading element with supplied props", ->
    heading = Test.renderIntoDocument(`<Heading className="heading--special" text="Bam" />`)
    element = Test.findRenderedDOMComponentWithTag(heading, "h1").getDOMNode()
    expect(element.className).toBe("heading heading--special")
    expect(element.firstChild.innerHTML).toBe("Bam")

  it "renders an icon when the prop is supplied", ->
    heading = Test.renderIntoDocument(`<Heading icon="fa-lock" text="Bam" />`)
    element = Test.findRenderedDOMComponentWithTag(heading, "h1").getDOMNode()
    expect(element.firstChild.tagName).toBe("I")
