jest.dontMock("../routes")
jest.dontMock("lodash")

describe "routes", ->

  describe "urlFor", ->
    it "returns the url for the specified route", ->
      Routes = require("../routes")
      expect(Routes.urlFor("LOGIN")).toBe("/oauth/token")

    it "replaces tokens with values from object", ->
      Routes = require("../routes")
      routeObject = { id: 1, name: "thingy" }
      expect(Routes.urlFor("TEST_ROUTE", routeObject)).toBe("/users/1/thingy")
