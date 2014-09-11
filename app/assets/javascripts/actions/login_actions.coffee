Dispatcher = require("../dispatcher.coffee")
Constants = require("../constants/login_constants.coffee")

LoginActions =
  authenticate: (username, password) ->
    Dispatcher.dispatchAction
      actionType: Constants.LOGIN_AUTHENTICATE
      username: username
      password: password

module.exports = LoginActions
