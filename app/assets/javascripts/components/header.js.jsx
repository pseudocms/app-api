/** @jsx React.DOM */

var React    = require("react");
var Icon     = require("./icon");
var LinkList = require("./link_list");
var Heading  = require("./heading");


var LINKS = [
  { text: "Lorem", url: "#" },
  { text: "Ipsum", url: "#" },
  { text: "Logout", url: "#" }
];

var Header = React.createClass({
  render: function() {
    return (
      <div className="site-header">
        <Heading text="PseudoCMS" iconType="fa-cogs" className="site-header__title" />
        <LinkList links={LINKS} className="link-list--right site-header__nav" />
      </div>
    );
  }
});

module.exports = Header;
