###* @jsx React.DOM ###

React = require("react")

Icon = React.createClass
  render: ->
    @transferPropsTo(`<i className="fa"></i>`)

module.exports = Icon
