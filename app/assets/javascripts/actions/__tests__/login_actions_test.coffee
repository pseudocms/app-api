jest.dontMock("../login_actions")

describe "Login Actions", ->
  Dispatcher = null
  LoginActions = null

  beforeEach ->
    Dispatcher = require("../../dispatcher")
    LoginActions = require("../login_actions")
    spyOn(Dispatcher, "dispatchAction")

  describe "authenticate", ->

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

  describe "postToken", ->

    it "dispatches the LOGIN_POST_TOKEN event", ->
      expectedParam =
        actionType: "LOGIN_POST_TOKEN"

      LoginActions.postToken()
      expect(Dispatcher.dispatchAction).toHaveBeenCalledWith(expectedParam)
