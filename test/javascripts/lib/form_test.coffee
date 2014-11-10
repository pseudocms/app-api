fixture.preload("form.html")

suite "Form", ->

  setup ->
    fixture.load("form.html")
    @form = new App.Form($("form"))

  test "start in a clean state", ->
    assert.isFalse @form.isDirty

  test "becomes dirty when a text field is changed", ->
    $("[name=text]").val("Make Dirty").trigger("change")
    assert @form.isDirty

  test "becomes dirty when a text area is changed", ->
    $("[name=textarea]").val("Make Dirty").trigger("change")
    assert @form.isDirty

  test "becomes dirty when a select option is changed", ->
    $("[name=select]").val("1").trigger("change")
    assert @form.isDirty

  test "becomes dirty when a checkbox is checked", ->
    $("[name=checkbox]").prop("checked", true).trigger("change")
    assert @form.isDirty

  test "returns to a clean state when things return to their initial state", ->
    $textField = $("[name=text]")
    originalValue = $textField.val()
    assert.isFalse @form.isDirty

    $textField.val("Make Dirty").trigger("change")
    assert @form.isDirty

    $textField.val(originalValue).trigger("change")
    assert.isFalse @form.isDirty

  test "disables primary buttons when in a clean state", ->
    $submitButton = $("[type=submit]")
    assert.isFalse $submitButton.hasClass("btn--primary")
    assert $submitButton.hasClass("btn--disabled")
    assert $submitButton.prop("disabled")

  test "enables primary buttons when in a dirty state", ->
    $("[name=text]").val("Make Dirty").trigger("change")

    $submitButton = $("[type=submit]")
    assert $submitButton.hasClass("btn--primary")
    assert.isFalse $submitButton.hasClass("btn--disabled")
    assert.isFalse $submitButton.prop("disabled")
