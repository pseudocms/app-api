_ = require("lodash")

INITIALIZERS = [
  require("./initializers/react"),
  require("./initializers/form")
]

module.exports =
  runInitializers: ->
    _.each INITIALIZERS, (initializer, index) ->
      initializer.init()
