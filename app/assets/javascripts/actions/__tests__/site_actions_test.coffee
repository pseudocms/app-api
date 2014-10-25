jest.dontMock("../site_actions")

Dispatcher  = require("../../dispatcher")
SiteActions = require("../site_actions")
Constants   = require("../../constants/site_constants")

Api = require("../../lib/api")
Api.setStorage(getItem: (name) -> "")

apiResponse = (success = true) ->
  done: (fn) -> fn() if success
  fail: (fn) -> fn() unless success

describe "Site Actions", ->
  describe "getAll", ->

    it "dispatches the action", ->
      spyOn(Api, 'get').andReturn(apiResponse())
      spyOn(Dispatcher, "dispatchAction")

      SiteActions.getAll()
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(actionType: Constants.GET_SITES)

    it "gets the sites from the API", ->
      spyOn(Api, 'get').andReturn(apiResponse())

      SiteActions.getAll()
      expect(Api.get).toHaveBeenCalledWith("/sites")

    it "dispatches GET_SITES_COMPLETED when the request is successful", ->
      spyOn(Api, 'get').andReturn(apiResponse())
      spyOn(Dispatcher, "dispatchData")

      SiteActions.getAll()
      expect(Dispatcher.dispatchData).toHaveBeenCalledWith(actionType: Constants.GET_SITES_COMPLETED)

    it "dispatches GET_SITES_FAILED when the request fails", ->
      spyOn(Api, 'get').andReturn(apiResponse(false))
      spyOn(Dispatcher, "dispatchAction")

      SiteActions.getAll()
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(actionType: Constants.GET_SITES_FAILED)
