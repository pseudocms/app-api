jest.dontMock("../form")
jest.dontMock("jquery")
jest.dontMock("lodash")

$    = require("jquery")
Form = require("../form")


$.fn.changeVal = (value) ->
  $(this).val(value).trigger("change")

$.fn.check = ->
  $(this).prop("checked", true).trigger("change")

describe "Form", ->
  beforeEach ->
    document.body.innerHTML = """
    <form>
      <input name="text" type="text" placeholder="initial value">
      <input name="checkbox" type="checkbox">
      <select name="select">
        <option value="" selected>Select one...</option>
        <option value="1">First Option</option>
        <option value="2">Second Option</option>
      </select>
      <textarea name="textarea">
        Initial Value
      </text>
      <input type="submit" class="btn btn--primary js-primary-action">
    </form>
    """

    @$form = new Form($("form"))
    @$textField = $("[name='text']")
    @$selectField = $("[name='select']")
    @$checkboxField = $("[name='checkbox']")
    @$textareaField = $("[name='textarea']")
    @$submitButton = $("[type='submit']")

  it "starts out in a clean state", ->
    expect(@$form.isDirty).toBe(false)

  it "becomes dirty when a text field is changed", ->
    @$textField.changeVal("Make Dirty")
    expect(@$form.isDirty).toBe(true)

  it "becomes dirty when a select option is changed", ->
    @$selectField.changeVal("1")
    expect(@$form.isDirty).toBe(true)

  it "becomes dirty when a checkbox is checked", ->
    @$checkboxField.check()
    expect(@$form.isDirty).toBe(true)

  it "becomes dirty when a textarea is checked", ->
    @$textareaField.changeVal("New Value")
    expect(@$form.isDirty).toBe(true)

  it "returns to clean state when things return to their initial state", ->
    originalValue = @$textField.val()

    @$textField.changeVal("Make Dirty")
    expect(@$form.isDirty).toBe(true)

    @$textField.changeVal(originalValue)
    expect(@$form.isDirty).toBe(true)

  it "disables primary buttons when in a clean state", ->
    expect(@$submitButton.hasClass("btn--primary")).toBe(false)
    expect(@$submitButton.hasClass("btn--disabled")).toBe(true)
    expect(@$submitButton.prop("disabled")).toBe(true)

  it "enables primary buttons when in a dirty state", ->
    @$textField.changeVal("Something")
    expect(@$submitButton.hasClass("btn--primary")).toBe(true)
    expect(@$submitButton.hasClass("btn--disabled")).toBe(false)
    expect(@$submitButton.prop("disabled")).toBe(false)
