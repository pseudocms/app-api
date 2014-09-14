/** @jsx React.DOM */

var React        = require("react");
var Repository   = require("../stores/login_store");
var LoginActions = require("../actions/login_actions");
var Formats      = require("../constants/formats");
var Input        = require("./input");
var Errors       = require("./errors");
var Heading      = require("./heading");

var Card        = require("./card").Card;
var CardHeader  = require("./card").CardHeader;
var CardContent = require("./card").CardContent;

var InputField = React.createClass({
  render: function() {
    return (
      <div className="form__field">
        <label className="form__label" htmlFor={this.props.name}>{this.props.label}</label>
        {this.transferPropsTo(<Input type={this.props.name} className="form__input required" />)}
      </div>
    );
  }
});

var LoginButton = React.createClass({
  render: function() {
    return (
      <div className="form__field--actions">
        {this.transferPropsTo(<button className="btn">Login</button>)}
      </div>
    );
  }
});

var LoginForm = React.createClass({
  getInitialState: function() {
    return { email: "", password: "", errors: [] }
  },

  componentDidMount: function() {
    Repository.addSuccessListener(this._onLoginSucceeded);
    Repository.addFailListener(this._onLoginFailed);
  },

  componentWillUnmount: function() {
    Repository.removeSuccessListener(this._onLoginSucceeded);
    Repository.removeFailListener(this._onLoginFailed);
  },

  render: function() {
    var validEmail = this._emailIsValid();
    var validPassword = this._passwordIsValid();

    return (
      <Card className="card--login">
        <CardHeader>
          <Heading iconType="fa-lock" text="Please Login" />
        </CardHeader>
        <CardContent>
          <div className="form">
            <Errors message="Oops! Looks liks something went wrong." errors={this.state.errors} />
            <InputField label="Email" name="email" valid={validEmail} value={this.state.email} onChange={this._valueChanged} placeholder="user@example.com" />
            <InputField label="Password" name="password" valid={validPassword} value={this.state.password} onChange={this._valueChanged} />
            <LoginButton onClick={this._login} />
          </div>
        </CardContent>
        <form action="/admin/login" method="post">
          <input type="hidden" name="auth_token" />
        </form>
      </Card>
    );
  },

  _valueChanged: function(e) {
    var update = {};
    update[e.target.name] = e.target.value;
    this.setState(update);
  },

  _login: function(e) {
    e.target.blur();
    LoginActions.authenticate(this.state.email, this.state.password);
  },

  _onLoginSucceeded: function() {
    LoginActions.postToken();
  },

  _onLoginFailed: function() {
    var errors = Repository.getLoginErrors()
    this.setState({ errors: errors, password: "" });
  },

  _emailIsValid: function() {
    return Formats.EMAIL_PATTERN.test(this.state.email);
  },

  _passwordIsValid: function() {
    return this.state.password !== "";
  }
});

module.exports = LoginForm;
