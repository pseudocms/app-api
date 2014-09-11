/** @jsx React.DOM */

var React = require("react");

var Icon = React.createClass({
  render: function() {
    var classes = "fa"
    return this.transferPropsTo(<i className={classes}></i>);
  }
});

module.exports = Icon;
