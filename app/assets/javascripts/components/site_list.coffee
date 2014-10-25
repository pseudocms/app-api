###* @jsx React.DOM ###

React   = require("react")
Store   = require("../stores/site_store")
Actions = require("../actions/site_actions")

SiteList = React.createClass
  getInitialState: ->
    { sites: [] }

  componentDidMount: ->
    Store.addChangeListener(@_onSitesChanged)
    Actions.getAll()

  componentWillUnmount: ->
    Store.removeChangeListener(@_onSitesChanged)

  render: ->
    rows = @state.sites.map (site) ->
      `(
        <tr key={site.id}>
          <td>{site.name}</td>
          <td>{site.owner.email}</td>
          <td>{site.created_at}</td>
        </tr>
      )`

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
          {rows}
        </tbody>
      </table>
    `

  _onSitesChanged: (sites) ->
    @setState(sites: sites)

module.exports = SiteList
