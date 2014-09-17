$ = require("jquery")

submitForm = (e) ->
  $(e.currentTarget).find(".js-btn--submit").click()

FormManager = {
  initialize: (options) ->
    $(".js-form").keypress (e) ->
      submitForm(e) if e.which is 13
}

module.exports = FormManager
