/** @jsx React.DOM */

var React = require("react");

var CardContent = React.createClass({
  render: function() {
    return this.transferPropsTo(
      <section className="card__content">
        {this.props.children}
      </section>
    )
  }
});

var CardHeader = React.createClass({
  render: function() {
    return this.transferPropsTo(
      <header className="card__header">
        {this.props.children}
      </header>
    );
  }
});

var Card = React.createClass({
  propTypes: {
    children: React.PropTypes.arrayOf(React.PropTypes.component).isRequired
  },
  render: function() {
    return this.transferPropsTo(
      <section className="card">
        {this.props.children}
      </section>
    );
  }
});

module.exports = {
  Card: Card,
  CardHeader: CardHeader,
  CardContent: CardContent
};
