Dispatcher = require("../dispatcher")
Constants  = require("../constants/route_constants")

ROUTES =
  LOGIN: "/oauth/token"
  TEST_ROUTE: "/users/{id}/{name}"

RouteHelper =
  urlFor: (endPoint, valueObject) ->
    route = ROUTES[endPoint]
    return route unless route && valueObject

    @_replaceTokens(route, valueObject)

  _replaceTokens: (route, valueObject) ->
    tokens = Object.keys(valueObject)
    route = route.replace(///\{#{token}\}///g, valueObject[token]) for token in tokens
    route


Dispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when Constants.NAVIGATE
      route = RouteHelper.urlFor(action.route, action.routeValues)
      Turbolinks.visit(route)

  true

module.exports = RouteHelper
