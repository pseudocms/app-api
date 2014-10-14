###* @jsx React.DOM ###

React = require("react")

Box = React.createClass
  render: ->
    @transferPropsTo `
      <div className="box">
        {this.props.children}
      </div>
    `

module.exports = Box
