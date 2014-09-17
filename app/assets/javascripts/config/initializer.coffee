$ = require("jquery")

Initializers = [
  require("./initializers/routes"),
  require("./initializers/components"),
  require("./initializers/focus"),
  require("./initializers/forms")
]

initializationOptions = null

runInitializers = ->
  Initializers.map (initializer) ->
    initializer.initialize(initializationOptions)

module.exports =
  initialize: (options) ->
    initializationOptions = options
    $(document).on("page:load", runInitializers)
    $ -> runInitializers()
