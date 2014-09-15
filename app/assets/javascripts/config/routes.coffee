# use protocol relative urls by default
BASE_URL = "//#{document.location}"
PARAM_PATTERN = /:[^\/$]+(\/|$)/

camelize = (string) ->
  string.replace /(?:[-_])(\w)/g, (dontCare, char) ->
    if char then char.toUpperCase() else ""

addRoute = (name, value) ->
  RouteSet["#{name}Path"] = -> buildRoute(value, arguments)
  RouteSet["#{name}Url"] = -> buildRoute("#{BASE_URL}#{value}", arguments)

buildRoute = (route, args) ->
  return route unless args && args.length
  return route unless PARAM_PATTERN.test(route)

  if args.length is 1 && args[0] instanceof Object
    buildRouteWithObject(route, args[0])
  else
    buildRouteWithValues(route, args)

buildRouteWithObject = (route, fromObject) ->
  for key in Object.keys(fromObject)
    route = route.replace(///:#{key}(\/|$)///g, "#{fromObject[key].toString()}$1")

  route

buildRouteWithValues = (route, values) ->
  while PARAM_PATTERN.test(route) && values.length
    param = [].shift.call(values).toString()
    route = route.replace(PARAM_PATTERN, "#{param}$1")

  route

RouteSet =
  setBaseUrl: (protocol_and_host) ->
    BASE_URL = protocol_and_host.replace(/\/$/, '')

  initRoutes: (routes) ->
    Object.keys(routes).map (key) ->
      addRoute(camelize(key), routes[key])

module.exports = RouteSet
