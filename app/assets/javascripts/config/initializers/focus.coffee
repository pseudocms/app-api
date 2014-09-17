$ = require("jquery")

Focuser = {
  initialize: (options) ->
    $(".container input:first:visible").focus()
}

module.exports = Focuser
