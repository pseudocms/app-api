Dispatcher = require("../dispatcher")
Constants = require("../constants/login_constants")

LoginActions =
  authenticate: (username, password) ->
    Dispatcher.dispatchAction
      actionType: Constants.LOGIN_AUTHENTICATE
      username: username
      password: password

  postToken: ->
    Dispatcher.dispatchAction
      actionType: Constants.LOGIN_POST_TOKEN

module.exports = LoginActions