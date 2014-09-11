merge = require("react/lib/merge")
EventEmitter = require("events").EventEmitter
Dispatcher = require("../dispatcher.coffee")
Constants = require("../constants/login_constants.coffee")
Api = require("../lib/api.coffee")

SUCCESS_EVENT = "LOGIN_SUCCEEDED"
FAIL_EVENT = "LOGIN_FAILED"

errors = null

login = (username, password) ->
  Api.clearAuthToken()
  errors = null

  op = Api.post Api.Endpoints.LOGIN,
    grant_type: "password"
    username: username
    password: password

  op.done (data, status, xhr) ->
    Api.storeAuthToken(data.access_token)
    LoginStore.emit(SUCCESS_EVENT)

  op.fail (xhr, status, errorThrown) ->
    errors = ["Invalid username/password combination"]
    LoginStore.emit(FAIL_EVENT)

LoginStore = merge EventEmitter.prototype,
  addSuccessListener: (callback) -> @on(SUCCESS_EVENT, callback)
  addFailListener: (callback) -> @on(FAIL_EVENT, callback)
  removeSuccessListener: (callback) -> @removeListener(SUCCESS_EVENT, callback)
  removeFailListener: (callback) -> @removeListener(FAIL_EVENT, callback)
  getLoginErrors: -> errors

Dispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when Constants.LOGIN_AUTHENTICATE
      login(action.username, action.password)

  true

module.exports = LoginStore
