merge = require("react/lib/merge")
EventEmitter = require("events").EventEmitter
Dispatcher = require("../dispatcher.coffee")
Constants = require("../constants/login_constants.coffee")

SUCCESS_EVENT = "LOGIN_SUCCEEDED"
FAIL_EVENT = "LOGIN_FAILED"

loginErrors = null

login = (username, password) ->
  op = $.ajax
    accept: "vnd.pseudocms.v1+json"
    url: "/oauth/token"
    type: "POST"
    data:
      grant_type: "password"
      username: username
      password: password

  op.done (data, status, xhr) ->
    storeToken(data.access_token)
    LoginStore.emit(SUCCESS_EVENT)

  op.fail (xhr, status, errorThrown) ->
    clearToken()
    loginErrors = ["Invalid username/password combination"]
    LoginStore.emit(FAIL_EVENT)

storeToken = (token) ->
  localStorage[Constants.PSEUDOCMS_TOKEN] = token

clearToken = ->
  delete localStorage[Constants.PSEUDOCMS_TOKEN]

LoginStore = merge EventEmitter.prototype,
  addSuccessListener: (callback) -> @on(SUCCESS_EVENT, callback)
  addFailListener: (callback) -> @on(FAIL_EVENT, callback)
  removeSuccessListener: (callback) -> @removeListener(SUCCESS_EVENT, callback)
  removeFailListener: (callback) -> @removeListener(FAIL_EVENT, callback)

  getLoginToken: ->
    localStorage[Constants.PSEUDOCMS_TOKEN]

  getLoginErrors: ->
    loginErrors

Dispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when Constants.LOGIN_AUTHENTICATE
      login(action.username, action.password)

  true

module.exports = LoginStore
