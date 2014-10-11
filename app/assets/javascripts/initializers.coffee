_ = require("lodash")

INITIALIZERS = [
  require("./initializers/react")
]

module.exports =
  runInitializers: ->
    _.each INITIALIZERS, (initializer, index) ->
      initializer.init()
