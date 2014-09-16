/** @jsx React.DOM */

var React    = require("react");
var Icon     = require("./icon");
var LinkList = require("./link_list");
var Heading  = require("./heading");

function logout(e) {
  e.preventDefault();
  alert("Logging out");
}

var LINKS = [
  { text: "Lorem", href: "#" },
  { text: "Ipsum", href: "#" },
  { text: "Logout", href: "adminLogoutPath", onClick: logout }
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
