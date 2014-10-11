###* @jsx React.DOM ###

React = require("react")
Icon = require("./icon")

Heading = React.createClass
  propTypes:
    icon: React.PropTypes.string
    text: React.PropTypes.string.isRequired

  render: ->
    icon = null
    icon = `<Icon className={this.props.icon} />` if @props.icon

    @transferPropsTo `
      <h1 className="heading">{icon}{this.props.text}</h1>
    `
module.exports = Heading
