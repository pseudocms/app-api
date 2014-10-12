_    = require("lodash")
Form = require("../lib/form")

module.exports =
  init: ->
    _.each document.querySelectorAll("form"), (form) ->
      new Form(form)
