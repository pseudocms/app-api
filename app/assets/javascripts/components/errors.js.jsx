/** @jsx React.DOM */

var React = require("react");

var ErrorList = React.createClass({
  render: function() {
    var count = 0;
    var items = this.props.errors.map(function(error) {
      return <li key={count++}>{error}</li>;
    });

    return <ul>{items}</ul>;
  }
});

var Errors = React.createClass({
  render: function() {
    if (!this.props.errors || !this.props.errors.length) {
      return null;
    }

    return (
      <div className="form__errors">
        <h1>{this.props.message}</h1>
        <ErrorList errors={this.props.errors} />
      </div>
    )
  }
});

module.exports = Errors;
