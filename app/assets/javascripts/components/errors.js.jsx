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
    if (this._noErrorsProvided()) return null;

    var message = null;
    if (this._messageProvided()) {
      message = <h1>{this.props.message}</h1>;
    }

    return (
      <div className="form__errors">
        {message}
        <ErrorList errors={this.props.errors} />
      </div>
    );
  },
  _noErrorsProvided: function() {
    return !(this.props.errors && this.props.errors.length);
  },
  _messageProvided: function() {
    return (this.props.message && this.props.message.length);
  }
});

module.exports = Errors;
