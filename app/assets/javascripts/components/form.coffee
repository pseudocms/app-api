###* @jsx React.DOM ###

React = require("react")
Format = require("../constants/format.coffee")

Form = React.createClass
  render: ->
    @transferPropsTo `
    <div className="form"></div>
    `

Field = React.createClass
  propTypes:
    label: React.PropTypes.string
    format: React.PropTypes.string

  getInitialState: ->
    value: @props.value

  render: ->
    label = if @props.label then @_label() else null
    field = @_input()

    `(
      <div className="form__field">
        {label}
        {field}
      </div>
    )`

  _label: ->
    `<label className="form__label" htmlFor={this.props.id}>{this.props.label}</label>`

  _input: ->
    classes = ["form__input"]
    if @props.format && @state.value
      validClass = if Format[@props.format].test(@state.value) then "valid" else "invalid"
      classes.push(validClass)

    @transferPropsTo `
      <input value={this.state.value} className={classes.join(" ")} onChange={this._inputValueChanged} />
    `

  _inputValueChanged: (event) ->
    @setState(value: event.target.value)

module.exports =
  Form: Form
  FormField: Field
