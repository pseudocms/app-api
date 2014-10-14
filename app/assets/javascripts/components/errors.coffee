###* @jsx React.DOM ###

_     = require("lodash")
React = require("react")
Box   = require("./box")

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
      <Box className="box--errors">
        <h1>{this.props.title}</h1>
        <List messages={this.props.messages} />
      </Box>
    `

module.exports = Errors
