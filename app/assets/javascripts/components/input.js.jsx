/** @jsx React.DOM */

var _     = require("lodash");
var React = require("react/addons");

var Input = React.createClass({
  propTypes: {
    valid: React.PropTypes.bool
  },

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
      this._prepareToValidate = _.debounce(validate, 500);
    }
  },
  render: function() {
    var classes = ""

    if (this.state.shouldValidate) {
      classes = React.addons.classSet({
        "valid": this.props.valid,
        "invalid": !this.props.valid
      });
    }

    return this.transferPropsTo(<input className={classes} onChange={this._handleChanged} />);
  },

  _prepareToValidate: function() {},

  _handleChanged: function(e) {
    if(!this.state.shouldValidate) {
      this._prepareToValidate();
    }

    this.props.onChange && this.props.onChange(e);
  }
});

module.exports = Input;
