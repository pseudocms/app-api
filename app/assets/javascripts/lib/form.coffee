class App.Form
  PRIMARY_BUTTONS = ".js-primary-action"

  constructor: (form, @options = {}) ->
    @$form = $(form)
    @$form.on("input change paste", @_updateState)

    @primaryButtons = @$form.find(PRIMARY_BUTTONS)

    @initialValues = @_fieldValues()
    @_makeClean()

  _updateState: (event) =>
    if _.isEqual(@_fieldValues(), @initialValues)
      @_makeClean()
    else
      @_makeDirty()

  _makeDirty: ->
    @isDirty = true
    @primaryButtons.removeClass("btn--disabled")
    @primaryButtons.addClass("btn--primary").prop("disabled", false)

  _makeClean: ->
    @isDirty = false
    @primaryButtons.removeClass("btn--primary")
    @primaryButtons.addClass("btn--disabled").prop("disabled", true)

  _fieldValues: ->
    inputs = @$form.find("input, select, textarea")
    _.map inputs, (input) ->
      if input.type in ["checkbox", "radio"] then input.checked else input.value
