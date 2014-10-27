###* @jsx React.DOM ###

React = require("react")

Toolbar = React.createClass
  render: ->
    @transferPropsTo `
      <div className="toolbar">
        <section className="toolbar__container">
          {this.props.children}
        </section>
      </div>
    `

module.exports = Toolbar
