_ = require("lodash")

INITIALIZERS = [
  require("./initializers/react"),
  require("./initializers/form"),
  require("./initializers/handlers")
]

module.exports =
  runInitializers: ->
    _.each INITIALIZERS, (initializer, index) ->
      initializer.init()
