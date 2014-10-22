###* @jsx React.DOM ###

jest.dontMock("../navigation")

React              = require("react/addons")
Test               = React.addons.TestUtils
{Link, Navigation} = require("../navigation")

describe "Navigation", ->

  it "transfers props to the nav element", ->
    nav = Test.renderIntoDocument(`<Navigation className="main-nav" />`)
    node = Test.findRenderedDOMComponentWithTag(nav, "nav").getDOMNode()
    expect(node.className).toBe("navigation main-nav")

  it "renders a navigation__container element", ->
    nav = Test.renderIntoDocument(`<Navigation className="main-nav" />`)
    node = Test.findRenderedDOMComponentWithTag(nav, "ul").getDOMNode()
    expect(node.className).toBe("navigation__container")

  it "renders Link children inside the container", ->
    nav = Test.renderIntoDocument `
      <Navigation>
        <Link href="http://www.google.com/" title="Some Link">Content</Link>
      </Navigation>
    `
    li = Test.findRenderedDOMComponentWithTag(nav, "li").getDOMNode()
    expect(li.className).toBe("navigation__item")

    node = Test.findRenderedDOMComponentWithTag(nav, "a").getDOMNode()
    expect(node.href).toBe("http://www.google.com/")
    expect(node.title).toBe("Some Link")
    expect(node.innerHTML).toBe("Content")
