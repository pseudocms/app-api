_ = require("lodash")

Endpoints =
  LOGIN: "/oauth/token"
  TEST_ROUTE: "/users/{id}/{name}"

ReplaceTokens = (route, tokenObject) ->
  _.forIn tokenObject, (value, key) ->
    route = route.replace("{#{key}}", value)

  route

RouteHelper =
  urlFor: (endPoint, valueObject) ->
    route = Endpoints[endPoint]
    return route unless route && valueObject

    ReplaceTokens(route, valueObject)

module.exports = RouteHelper
