###* @jsx React.DOM ###

React = require("react")

Cell = React.createClass
  render: ->
    @transferPropsTo `
      <div className="grid__cell">
        {this.props.children}
      </div>
    `

Grid = React.createClass
  propTypes:
    children: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Cell)).isRequired

  render: ->
    @transferPropsTo `
      <div className="grid">
        {this.props.children}
      </div>
    `

module.exports =
  Grid: Grid
  GridCell: Cell
