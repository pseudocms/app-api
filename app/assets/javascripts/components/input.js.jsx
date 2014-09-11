/** @jsx React.DOM */

var React = require("react");

var Input = React.createClass({
  getInitialState: function() {
    return { shouldValidate: false };
  },

  componentWillMount: function() {
    var validate = function() {
      this.setState({ shouldValidate: true });
    }.bind(this);

    if (this.props.value) {
      validate();
    } else {
      this.prepareToValidate = _.debounce(validate, 500);
    }
  },
  handleChanged: function(e) {
    if(!this.shouldValidate) {
      this.prepareToValidate();
    }

    this.props.onChange && this.props.onChange(e);
  },
  render: function() {
    var className = "";
    if (this.state.shouldValidate) {
      className = this.props.valid  ? "valid" : "invalid";
    }
    return this.transferPropsTo(<input className={className} onChange={this.handleChanged} />);
  },

  prepareToValidate: function() {}
});

module.exports = Input;
