###* @jsx React.DOM ###

jest.dontMock("../site_list")
jest.dontMock("../../dispatcher")

React    = require("react/addons")
Test     = React.addons.TestUtils
SiteList = require("../site_list")
Actions  = require("../../actions/site_actions")

describe "Site List", ->
  beforeEach ->
    spyOn(Actions, "getAll")
    @table = Test.renderIntoDocument(`<SiteList className="table--wide" />`)

  describe "Basic rendering", ->

    it "transfers props to the table", ->
      node = Test.findRenderedDOMComponentWithTag(@table, "table").getDOMNode()
      expect(node.className).toBe("table table--wide")

    it "renders a row for each result", ->
      sites = [
        { name: "Site 1", owner: { id: 1, email: "blah" }},
        { name: "Site 2", owner: { id: 1, email: "blah" }}
      ]

      @table.onSitesChanged(results: sites)

      body = Test.findRenderedDOMComponentWithTag(@table, "tbody").getDOMNode()
      expect(body.children.length).toBe(sites.length)
