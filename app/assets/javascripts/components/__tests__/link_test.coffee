###* @jsx React.DOM ###

jest.dontMock("../link")
jest.dontMock("../../config/routes")

describe "Link", ->
  Utils = null

  beforeEach ->
    Utils = require("react/addons").addons.TestUtils

  describe "Simple Props", ->

    it "renders props.text as the innerHTML of the anchor tag", ->
      Link = require("../link")
      renderedLink = Utils.renderIntoDocument(`<Link text="My Link" href="/" />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.innerHTML).toBe("My Link")

    it "uses the href as specified when it's not a route", ->
      Link = require("../link")
      url = "https://google.com/?q=search&alt=within"
      renderedLink = Utils.renderIntoDocument(`<Link text="My Other Link" href={url} />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.href).toBe(url)

  describe "Using Routes", ->
    beforeEach ->
      @routes = require("../../config/routes")
      @routes.setBaseUrl("https://example.com/")
      @routes.initRoutes
        "adminRoot": "/admin"
        "user": "/users/:id"
        "userRole": "/users/:id/role/:role_id"

    it "uses the route definition", ->
      Link = require("../link")
      renderedLink = Utils.renderIntoDocument(`<Link text="My Link" href="adminRootUrl" />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.href).toBe("https://example.com/admin")

    it "gets route parameters from params", ->
      params = 1
      Link = require("../link")
      renderedLink = Utils.renderIntoDocument(`<Link text="My Link" href="userUrl" params={params} />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.href).toBe("https://example.com/users/1")

    it "allows object as params", ->
      params = { id: 2, role_id: "new" }
      Link = require("../link")
      renderedLink = Utils.renderIntoDocument(`<Link text="My Link" href="userRoleUrl" params={params} />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.href).toBe("https://example.com/users/2/role/new")

    it "allows array params", ->
      params = [1, 2]
      Link = require("../link")
      renderedLink = Utils.renderIntoDocument(`<Link text="My Link" href="userRoleUrl" params={params} />`)
      anchorTag = Utils.findRenderedDOMComponentWithTag(renderedLink, "a").getDOMNode()
      expect(anchorTag.href).toBe("https://example.com/users/1/role/2")
