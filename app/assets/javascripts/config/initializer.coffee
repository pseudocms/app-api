RouteManager     = require("./initializers/routes")
ComponentManager = require("./initializers/components")

module.exports =
  initialize: (options) ->
    [RouteManager, ComponentManager].map (initializer) ->
      initializer.initialize(options)
