Routes = require("../routes")

RouteManager = {
  initialize: (options) ->
    Routes.initRoutes(options.routes)
}

module.exports = RouteManager
