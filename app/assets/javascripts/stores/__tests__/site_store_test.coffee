jest.dontMock("../site_store")

Dispatcher  = require("../../dispatcher")
Store       = require("../site_store")
Constants   = require("../../constants/site_constants")

describe "Site Store", ->
  it "registers itself with the dispatcher", ->
    expect(Dispatcher.register.mock.calls.length).toBe(1)

  it "emits a change event when GET_SITES_COMPLETED is dispatched", ->
    spyOn(Store, 'emit')
    callback = Dispatcher.register.mock.calls[0][0]
    callback(action: { actionType: Constants.GET_SITES_COMPLETED, data: [1, 2, 3] })
    expect(Store.emit).toHaveBeenCalledWith(jasmine.any(String), [1, 2, 3])
