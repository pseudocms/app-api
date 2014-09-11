/** @jsx React.DOM */

var React = require("react");

var Input = React.createClass({
  getInitialState: function() {
    return { validationStarted: false };
  },

  componentWillMount: function() {
    var startValidating = function() {
      this.setState({ validationStarted: true });
    }.bind(this);

    if (this.props.value) {
      startValidating();
    } else {
      this.prepareToValidate = _.debounce(startValidating, 500);
    }
  },
  handleChanged: function(e) {
    if(!this.validationStarted) {
      this.prepareToValidate();
    }

    this.props.onChange && this.props.onChange(e);
  },
  render: function() {
    var className = "";
    if (this.state.validationStarted) {
      className = this.props.valid  ? "valid" : "invalid";
    }
    return this.transferPropsTo(<input className={className} onChange={this.handleChanged} />);
  },

  prepareToValidate: function() {}
});

module.exports = Input;
