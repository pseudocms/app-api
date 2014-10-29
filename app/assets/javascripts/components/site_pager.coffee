###* @jsx React.DOM ###

React = require("react")
Store = require("../stores/site_store")

Link = React.createClass
  render: ->
    `<li>{this._makeLink()}</li>`

  _makeLink: ->
    classNames = ["btn", "btn--slim", "pager__link"]
    classNames.push("disabled") unless this.props.href

    @transferPropsTo `
      <a className={classNames.join(' ')}>{this.props.children}</a>
    `

Pager = React.createClass
  getInitialState: -> { }

  componentDidMount: ->
    Store.addChangeListener(@onSitesChanged)

  componentWillUnmount: ->
    Store.removeChangeListener(@onSitesChanged)

  render: ->
    return null unless @state.results && @state.results.length

    `(
      <ul className="pager">
        <Link href={this.state.prevPage} className="pager__link--prev">&lt;</Link>
        <Link href={this.state.nextPage} className="pager__link--next">&gt;</Link>
      </ul>
    )`

  onSitesChanged: (paginatedResults) ->
    @setState(paginatedResults)

module.exports = Pager
