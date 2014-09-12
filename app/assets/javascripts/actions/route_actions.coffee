Dispatcher = require("../dispatcher")
Constants  = require("../constants/route_constants")

RouteActions =
  visit: (route, routeValues) ->
    Dispatcher.dispatchAction
      actionType: Constants.NAVIGATE
      route: route
      routeValues: routeValues

module.exports = RouteActions
