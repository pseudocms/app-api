###* @jsx React.DOM ###

React = require("react")

Form = React.createClass
  render: ->
    @transferPropsTo `
    <div className="form"></div>
    `

Field = React.createClass
  propTypes:
    label: React.PropTypes.string.isRequired

  render: ->
    label = @_label()
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
    @transferPropsTo `
      <input className="form__input" />
    `

module.exports =
  Form: Form
  FormField: Field
