###* @jsx React.DOM ###

jest.dontMock("../site_list")
jest.dontMock("../../dispatcher")

React    = require("react/addons")
Test     = React.addons.TestUtils
SiteList = require("../site_list")
Api      = require("../../lib/api")

apiResponse = (data = {}, success = true) ->
  done: (fn) -> fn(data) if success
  fail: (fn) -> fn(data) unless success

describe "Site List", ->

  it "transfers props to the table", ->
    spyOn(Api, "get").andReturn(apiResponse())
    table = Test.renderIntoDocument(`<SiteList className="table--wide" />`)
    node = Test.findRenderedDOMComponentWithTag(table, "table").getDOMNode()
    expect(node.className).toBe("table table--wide")

  it "renders a row for each site on the current page", ->
    sites = [
      { name: "Site 1", owner: { id: 1, email: "blah" }},
      { name: "Site 2", owner: { id: 1, email: "blah" }},
    ]

    spyOn(Api, "get").andReturn(apiResponse(sites))
    table = Test.renderIntoDocument(`<SiteList className="table--wide" />`)

    table._onSitesChanged(sites)
    body = Test.findRenderedDOMComponentWithTag(table, "tbody").getDOMNode()
    expect(body.children.length).toBeGreaterThan(0)
