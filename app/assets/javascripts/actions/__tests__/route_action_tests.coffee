jest.dontMock("../route_actions")
jest.dontMock("../../constants/route_constants")

describe "RouteActions", ->
  describe "visit", ->
    Dispatcher = null
    RouteActions = null
    Constants = null

    beforeEach ->
      Dispatcher = require("../../dispatcher")
      RouteActions = require("../route_actions")
      Constants = require("../../constants/route_constants")
      spyOn(Dispatcher, "dispatchAction")

    it "calls dispatchAction with the right values", ->
      expected =
        actionType: Constants.NAVIGATE
        route: "LOGIN"
        routeValues: undefined

      RouteActions.visit("LOGIN")
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(expected)
