###* @jsx React.DOM ###

jest.dontMock("../page")

React = require("react/addons")
Test = React.addons.TestUtils
Page = require("../page")

describe "Page", ->
  it "renders a div with the page class", ->
    page = Test.renderIntoDocument(`<Page />`)
    Test.findRenderedDOMComponentWithClass(page, "page")

  it "transfers properties to the div", ->
    page = Test.renderIntoDocument(`<Page className="my-page" id="pageThang" />`)
    node = Test.findRenderedDOMComponentWithClass(page, "page").getDOMNode()
    expect(node.className).toBe("page my-page")
    expect(node.id).toBe("pageThang")

  it "renders children inside the page div", ->
    page = Test.renderIntoDocument `
      <Page>
        <nav>
          <ul>
            <li>My Item</li>
          </ul>
        </nav>
      </Page>
    `
    Test.findRenderedDOMComponentWithTag(page, "li")
