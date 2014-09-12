###* @jsx React.DOM ###

jest.dontMock("../card")

describe "Card", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "wraps children inside a card", ->
    Card = require("../card").Card
    card = @utils.renderIntoDocument(`<Card>Some Value</Card>`)
    node = @utils.findRenderedDOMComponentWithTag(card, "section").getDOMNode()
    expect(node.innerHTML).toBe("Some Value")

  it "transfers props to the surrounding card element", ->
    Card = require("../card").Card
    card = @utils.renderIntoDocument(`<Card className="one" id="cardThing" />`)
    node = @utils.findRenderedDOMComponentWithTag(card, "section").getDOMNode()
    expect(node.className).toBe("card one")
    expect(node.id).toBe("cardThing")

describe "CardHeader", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "wraps children inside a card header", ->
    CardHeader = require("../card").CardHeader
    header = @utils.renderIntoDocument(`<CardHeader>Some Value</CardHeader>`)
    node = @utils.findRenderedDOMComponentWithTag(header, "header").getDOMNode()
    expect(node.innerHTML).toBe("Some Value")

  it "transfers props to the surrounding card header element", ->
    CardHeader = require("../card").CardHeader
    header = @utils.renderIntoDocument(`<CardHeader className="one" id="cardThing" />`)
    node = @utils.findRenderedDOMComponentWithTag(header, "header").getDOMNode()
    expect(node.className).toBe("card__header one")
    expect(node.id).toBe("cardThing")

describe "CardContent", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "wraps children inside a card content block", ->
    CardContent = require("../card").CardContent
    header = @utils.renderIntoDocument(`<CardContent>Some Value</CardContent>`)
    node = @utils.findRenderedDOMComponentWithTag(header, "section").getDOMNode()
    expect(node.innerHTML).toBe("Some Value")

  it "transfers props to the surrounding card content element", ->
    CardContent = require("../card").CardContent
    header = @utils.renderIntoDocument(`<CardContent className="one" id="cardThing" />`)
    node = @utils.findRenderedDOMComponentWithTag(header, "section").getDOMNode()
    expect(node.className).toBe("card__content one")
    expect(node.id).toBe("cardThing")
