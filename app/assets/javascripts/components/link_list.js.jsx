/** @jsx React.DOM */

var React = require("react");
var count = 0;

var Link = React.createClass({
  propTypes: {
    text: React.PropTypes.string.isRequired,
    url: React.PropTypes.string.isRequired
  },

  render: function() {
    var link  = this.transferPropsTo(<a href={this.props.url}>{this.props.text}</a>);
    return <li key={count++}>{link}</li>;
  }
});

var LinkList = React.createClass({
  propTypes: {
    links: React.PropTypes.array.isRequired
  },

  render: function() {
    var links = this.props.links.map(function(link) {
      return Link(link);
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
