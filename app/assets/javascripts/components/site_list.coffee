###* @jsx React.DOM ###

_       = require("lodash")
React   = require("react")
Store   = require("../stores/site_store")
Actions = require("../actions/site_actions")

SiteList = React.createClass
  getInitialState: -> {}

  componentDidMount: ->
    Store.addChangeListener(@onSitesChanged)
    Actions.getAll()

  componentWillUnmount: ->
    Store.removeChangeListener(@onSitesChanged)

  render: ->
    @transferPropsTo `
      <table className="table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Owner</th>
            <th>Created At</th>
          </tr>
        </thead>
        <tbody>
          {this._rows()}
        </tbody>
      </table>
    `

  onSitesChanged: (paginatedResults) ->
    @setState(paginatedResults)

  _rows: ->
    _.map @state.results, (site) ->
      `(
        <tr key={site.id}>
          <td>{site.name}</td>
          <td>{site.owner.email}</td>
          <td>{site.created_at}</td>
        </tr>
      )`

module.exports = SiteList
