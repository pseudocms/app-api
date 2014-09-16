/** @jsx React.DOM */

var React = require("react");
var Link = require("./link");

var NavLink = React.createClass({
  propTypes: {
    text: React.PropTypes.string.isRequired,
    href: React.PropTypes.string.isRequired
  },

  render: function() {
    var link  = this.transferPropsTo(<Link />);
    return <li>{link}</li>;
  }
});

var LinkList = React.createClass({
  propTypes: {
    links: React.PropTypes.array.isRequired
  },

  render: function() {
    var count = 0;
    var links = this.props.links.map(function(link) {
      return NavLink(link);
    });

    return this.transferPropsTo(
      <nav className="link-list">
        <ul>
          {links}
        </ul>
      </nav>
    );
  }
});

module.exports = LinkList;
