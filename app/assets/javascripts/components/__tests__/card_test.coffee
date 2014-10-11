###* @jsx React.DOM ###

jest.dontMock("../card")

React = require("react/addons")
Test  = React.addons.TestUtils
{Card, CardHeader, CardContent} = require("../card")

describe "Card", ->

  it "transfers props to the surrounding card element", ->
    card = Test.renderIntoDocument(`<Card id="myCard" className="test" />`)
    element = Test.findRenderedDOMComponentWithTag(card, "section").getDOMNode()
    expect(element.id).toBe("myCard")
    expect(element.className).toBe("card test")

  it "renders children inside a card element", ->
    card = Test.renderIntoDocument(`<Card>Some Value</Card>`)
    element = Test.findRenderedDOMComponentWithTag(card, "section").getDOMNode()
    expect(element.innerHTML).toBe("Some Value")

  describe "Card Header", ->

    it "transfers props to the surrounding header element", ->
      cardHeader = Test.renderIntoDocument(`<CardHeader id="mycardHeader" className="test" />`)
      element = Test.findRenderedDOMComponentWithTag(cardHeader, "header").getDOMNode()
      expect(element.id).toBe("mycardHeader")
      expect(element.className).toBe("card__header test")

    it "renders children inside a header element", ->
      cardHeader = Test.renderIntoDocument(`<CardHeader>Some Value</CardHeader>`)
      element = Test.findRenderedDOMComponentWithTag(cardHeader, "header").getDOMNode()
      expect(element.innerHTML).toBe("Some Value")

  describe "Card Content", ->

    it "transfers props to the surrounding content element", ->
      cardContent = Test.renderIntoDocument(`<CardContent id="mycardContent" className="test" />`)
      element = Test.findRenderedDOMComponentWithTag(cardContent, "section").getDOMNode()
      expect(element.id).toBe("mycardContent")
      expect(element.className).toBe("card__content test")

    it "renders children inside a content element", ->
      cardContent = Test.renderIntoDocument(`<CardContent>Some Value</CardContent>`)
      element = Test.findRenderedDOMComponentWithTag(cardContent, "section").getDOMNode()
      expect(element.innerHTML).toBe("Some Value")
