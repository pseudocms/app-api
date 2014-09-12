jest.dontMock("../login_actions.coffee")

describe "Login Actions", ->

  describe "authenticate", ->
    Dispatcher = null
    LoginActions = null

    beforeEach ->
      Dispatcher = require("../../dispatcher.coffee")
      LoginActions = require("../login_actions.coffee")
      spyOn(Dispatcher, "dispatchAction")

    it "calls Dispatcher#dispatchAction", ->
      LoginActions.authenticate("user", "pass")
      expect(Dispatcher.dispatchAction).toHaveBeenCalled()

    it "sends username and password to dispatcher", ->
      expectedParam =
        actionType: "LOGIN_AUTHENTICATE"
        username: "user"
        password: "pass"

      LoginActions.authenticate("user", "pass")
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(expectedParam)
