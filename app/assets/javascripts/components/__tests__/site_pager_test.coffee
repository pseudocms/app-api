###* @jsx React.DOM ###

jest.dontMock("../site_pager")

React = require("react/addons")
Test  = React.addons.TestUtils
Pager = require("../site_pager")

describe "Site Pager", ->

  it "renders nothing if there are no results", ->
    pager = Test.renderIntoDocument(`<Pager />`)
    node = Test.scryRenderedDOMComponentsWithTag(pager, "div")
    expect(node.length).toBe(0)

  it "renders the correct state when both next and prev pages are available", ->
    state =
      results: ["Some Item"]
      hasPrevPage: true
      hasNextPage: true
      prevPage: "http://www.test.com/prev"
      nextPage: "http://www.test.com/next"

    pager = Test.renderIntoDocument(`<Pager />`)
    pager.onSitesChanged(state)

    prevLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--prev").getDOMNode()
    nextLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--next").getDOMNode()

    expect(nextLink.className).toNotMatch(/\bdisabled\b/)
    expect(prevLink.className).toNotMatch(/\bdisabled\b/)

  it "renders the correct state when on prev page is available", ->
    state =
      results: ["Some Item"]
      hasPrevPage: true
      hasNextPage: false
      prevPage: "http://www.test.com/"
      nextPage: ""

    pager = Test.renderIntoDocument(`<Pager />`)
    pager.onSitesChanged(state)

    prevLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--prev").getDOMNode()
    nextLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--next").getDOMNode()

    expect(nextLink.className).toMatch(/\bdisabled\b/)
    expect(prevLink.className).toNotMatch(/\bdisabled\b/)
    expect(prevLink.innerHTML).toBe("&lt;")
    expect(prevLink.href).toBe(state.prevPage)

  it "renders the correct state when only next page is available", ->
    state =
      results: ["Some Item"]
      hasPrevPage: false
      hasNextPage: true
      prevPage: ""
      nextPage: "http://www.test.com/"

    pager = Test.renderIntoDocument(`<Pager />`)
    pager.onSitesChanged(state)

    prevLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--prev").getDOMNode()
    nextLink = Test.findRenderedDOMComponentWithClass(pager, "pager__link--next").getDOMNode()

    expect(prevLink.className).toMatch(/\bdisabled\b/)
    expect(nextLink.className).toNotMatch(/\bdisabled\b/)
    expect(nextLink.innerHTML).toBe("&gt;")
    expect(nextLink.href).toBe(state.nextPage)
