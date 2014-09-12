###* @jsx React.DOM ###

jest.dontMock("../login_store")

onEventBehaviour = (eventName) ->
  describe "#{eventName} event", ->
    it "registers the callback with the event emitter", ->
      methodName = "add#{eventName}Listener"
      LoginStore = require("../login_store")
      spyOn(LoginStore, "on")

      cb = ->
      LoginStore[methodName](cb)
      expect(LoginStore.on).toHaveBeenCalledWith(jasmine.any(String), cb)

    it "unregisters the callback with the event emitter", ->
      methodName = "remove#{eventName}Listener"
      LoginStore = require("../login_store")
      spyOn(LoginStore, "removeListener")

      cb = ->
      LoginStore[methodName](cb)
      expect(LoginStore.removeListener).toHaveBeenCalledWith(jasmine.any(String), cb)

describe "LoginStore", ->
  it "registers itself with the dispatcher", ->
    Dispatcher = require("../../dispatcher")
    spyOn(Dispatcher, "register")

    LoginStore = require("../login_store")
    expect(Dispatcher.register).toHaveBeenCalled()

  describe "events", ->
    onEventBehaviour("Success")
    onEventBehaviour("Fail")
