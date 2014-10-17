###* @jsx React.DOM ###

React = require("react")

Card = React.createClass
  render: ->
    @transferPropsTo `
      <section className="card">
        {this.props.children}
      </section>
    `

Header = React.createClass
  render: ->
    @transferPropsTo `
      <header className="card__header">
        {this.props.children}
      </header>
    `

Footer = React.createClass
  render: ->
    @transferPropsTo `
      <footer className="card__footer">
        {this.props.children}
      </footer>
    `

Content = React.createClass
  render: ->
    @transferPropsTo `
      <section className="card__content">
        {this.props.children}
      </section>
    `

module.exports =
  Card: Card
  CardHeader: Header
  CardFooter: Footer
  CardContent: Content
