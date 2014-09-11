/** @jsx React.DOM */

var React = require("react");
var Repository = require("../stores/login_store.coffee");
var LoginActions = require("../actions/login_actions.coffee");
var Input = require("./input");
var Formats = require("../constants/formats.coffee");
var Errors = require("./errors");

var LoginForm = React.createClass({
  getInitialState: function() {
    return { username: "", password: "", errors: [] }
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
    var validEmail = this._usernameIsValid();
    var validPassword = this._passwordIsValid();

    return (
      <section className="card card--login">
        <header className="card__header">
          <h1><i className="fa fa-lock"></i>Please Login</h1>
        </header>
        <section className="card__content">
          <div className="form">
            <Errors message="Oops! Looks liks something went wrong." errors={this.state.errors} />
            <div className="form__field">
              <label className="form__label" htmlFor="email">Email:</label>
              <Input valid={validEmail} className="form__input required" value={this.state.username} onChange={this._usernameChanged} placeholder="user@example.com"/>
            </div>
            <div className="form__field">
              <label className="form__label" htmlFor="password">Password:</label>
              <Input valid={validPassword} type="password" className="form__input required" value={this.state.password} onChange={this._passwordChanged} />
            </div>
            <div className="form__field--actions">
              <button className="btn" onClick={this._login}>Login</button>
            </div>
          </div>
        </section>
      </section>
    );
  },

  _usernameChanged: function(e) {
    this.setState({ username: e.target.value });
  },
  _passwordChanged: function(e) {
    this.setState({ password: e.target.value });
  },

  _login: function() {
    LoginActions.authenticate(this.state.username, this.state.password);
  },

  _onLoginSucceeded: function() {
    document.location = "/admin";
  },

  _onLoginFailed: function() {
    var errors = Repository.getLoginErrors()
    this.setState({ errors: errors, password: "" });
  },

  _usernameIsValid: function() {
    return this.state.username.match(Formats.EMAIL_PATTERN);
  },

  _passwordIsValid: function() {
    return this.state.password !== "";
  }
});

module.exports = LoginForm;
