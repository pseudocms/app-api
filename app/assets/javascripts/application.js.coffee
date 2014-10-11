#= require turbolinks
#= require_self

$           = require("jquery")
Initializer = require("./initializers")

initialize = ->
  Initializer.runInitializers()

$ -> initialize()
$(document).on("page:load", initialize)
