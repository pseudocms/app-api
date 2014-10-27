jest.dontMock("../site_actions")

Dispatcher  = require("../../dispatcher")
SiteActions = require("../site_actions")
Constants   = require("../../constants/site_constants")
Pager       = require("../../lib/pager")

Api = require("../../lib/api")
Api.setStorage(getItem: (name) -> "")

apiResponse = (success = true) ->
  done: (fn) -> fn() if success
  fail: (fn) -> fn() unless success

describe "Site Actions", ->
  describe "getAll", ->
    beforeEach ->
      spyOn(Pager, "paginate")
      spyOn(Dispatcher, "dispatchAction")
      spyOn(Dispatcher, "dispatchData")
      spyOn(Api, "get").andReturn(apiResponse())

    it "dispatches the action", ->
      SiteActions.getAll()
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(actionType: Constants.GET_SITES)

    it "gets the sites from the API", ->
      SiteActions.getAll()
      expect(Api.get).toHaveBeenCalledWith("/sites")

    it "dispatches GET_SITES_COMPLETED when the request is successful", ->
      SiteActions.getAll()
      expect(Dispatcher.dispatchData).toHaveBeenCalledWith(actionType: Constants.GET_SITES_COMPLETED)

    it "paginates the JSON response", ->
      SiteActions.getAll()
      expect(Pager.paginate).toHaveBeenCalled()

    it "dispatches GET_SITES_FAILED when the request fails", ->
      Api.get.andReturn(apiResponse(false))

      SiteActions.getAll()
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(actionType: Constants.GET_SITES_FAILED)
