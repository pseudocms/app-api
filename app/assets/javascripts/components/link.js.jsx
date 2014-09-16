/** @jsx React.DOM */

var React  = require("react");
var Routes = require("../config/routes");

var Link = React.createClass({
  propTypes: {
    text: React.PropTypes.string.isRequired,
    href: React.PropTypes.string.isRequired,
    params: React.PropTypes.oneOfType([
      React.PropTypes.number,
      React.PropTypes.string,
      React.PropTypes.array,
      React.PropTypes.object
    ])
  },

  render: function() {
    var url = this._adjustedUrl();
    return this.transferPropsTo(<a href={url}>{this.props.text}</a>);
  },

  _adjustedUrl: function() {
    return this._isRoute() ? this._route() : this.props.href;
  },

  _isRoute: function() {
    return Routes.hasOwnProperty(this.props.href);
  },

  _route: function() {
    if (Array.isArray(this.props.params)) {
      return Routes[this.props.href].apply(Routes, this.props.params);
    } else {
      return Routes[this.props.href](this.props.params);
    }
  }
});

module.exports = Link;
