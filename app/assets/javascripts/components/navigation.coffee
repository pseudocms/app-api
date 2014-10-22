###* @jsx React.DOM ###

React = require("react")

Link = React.createClass
  render: ->
    anchor = @transferPropsTo `
      <a>{this.props.children}</a>
    `

    `<li className="navigation__item">{anchor}</li>`

Navigation = React.createClass
  propTypes:
    children: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Link))

  render: ->
    @transferPropsTo `
      <nav className="navigation">
        <ul className="navigation__container">
          {this.props.children}
        </ul>
      </nav>
    `

module.exports =
  Navigation: Navigation
  Link: Link
