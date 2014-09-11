/** @jsx React.DOM */

var React = require("react");
var Icon  = require("./icon");

var Heading = React.createClass({
  propTypes: {
    iconType: React.PropTypes.string,
    text: React.PropTypes.string.isRequired
  },

  render: function() {
    var icon = "";
    if (this.props.iconType) {
      icon = Icon({ className: this.props.iconType });
    }

    return this.transferPropsTo(<h1 className="heading">{icon}{this.props.text}</h1>);
  }
});

module.exports = Heading;
