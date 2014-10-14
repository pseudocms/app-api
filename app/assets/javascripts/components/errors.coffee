###* @jsx React.DOM ###

_     = require("lodash")
React = require("react")

List = React.createClass
  render: ->
    items = _.map @props.messages, (message, index) ->
      `<li key={index}>{message}</li>`

    `<ul>{items}</ul>`

Errors = React.createClass
  propTypes:
    title: React.PropTypes.string
    messages: React.PropTypes.arrayOf(React.PropTypes.string).isRequired

  render: ->
    @transferPropsTo `
      <div className="box box--errors">
        <h1>{this.props.title}</h1>
        <List messages={this.props.messages} />
      </div>
    `

module.exports = Errors
