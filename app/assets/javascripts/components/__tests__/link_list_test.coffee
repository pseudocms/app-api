###* @jsx React.DOM ###

jest.dontMock("../link_list")

describe "LinkList", ->
  beforeEach ->
    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "renders a nav element with merged properties", ->
    LinkList = require("../link_list")
    linkList = @utils.renderIntoDocument(`<LinkList className="nav" id="navBar" links={[]} />`)
    node = @utils.findRenderedDOMComponentWithTag(linkList, "nav").getDOMNode()
    expect(node.className).toBe("link-list nav")
    expect(node.id).toBe("navBar")

  it "renders links as list items", ->
    links = [
      { text: "Item 1", url: "/item1" },
      { text: "Item 2", url: "/item2" }
    ]

    LinkList = require("../link_list")
    linkList = @utils.renderIntoDocument(`<LinkList className="nav" id="navBar" links={links} />`)
    listItems = @utils.scryRenderedDOMComponentsWithTag(linkList, "li")
    expect(listItems.length).toBe(links.length)

  it "transfers link properties to the individual anchor tags", ->
    links = [
      { text: "Item 1", url: "http://item1.com/", className: "active" },
      { text: "Item 2", url: "/item2" }
    ]

    LinkList = require("../link_list")
    linkList = @utils.renderIntoDocument(`<LinkList className="nav" id="navBar" links={links} />`)
    linkElements = @utils.scryRenderedDOMComponentsWithTag(linkList, "a")

    activeLink = linkElements[0].getDOMNode()
    expect(activeLink.href).toBe(links[0].url)
    expect(activeLink.className).toBe(links[0].className)
    expect(activeLink.innerHTML).toBe(links[0].text)
