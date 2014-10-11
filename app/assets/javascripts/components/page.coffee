###* @jsx React.DOM ###

React = require("react")

Page = React.createClass
  render: ->
    @transferPropsTo `
      <div className="page">
        {this.props.children}
      </div>
    `

module.exports = Page
