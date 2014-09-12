jest.dontMock("../route_store")

describe "RouteStore", ->
  describe "urlFor", ->
    it "returns the url for the specified route", ->
      RouteStore = require("../route_store")
      expect(RouteStore.urlFor("LOGIN")).toBe("/oauth/token")

    it "replaces tokens with values from object", ->
      RouteStore = require("../route_store")
      routeObject = { id: 1, name: "thingy" }
      expect(RouteStore.urlFor("TEST_ROUTE", routeObject)).toBe("/users/1/thingy")
