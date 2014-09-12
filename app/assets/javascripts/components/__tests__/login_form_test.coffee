###* @jsx React.DOM ###

jest.dontMock("../login_form")

describe "LoginForm", ->
  beforeEach ->
    jest.setMock "lodash",
      debounce: (fn, time) ->
        -> fn()

    React = require("react/addons")
    @utils = React.addons.TestUtils

  it "sets email, password and errors to empty initially", ->
    LoginForm = require("../login_form")
    form = @utils.renderIntoDocument(`<LoginForm />`)
    expect(form.state.email).toBe("")
    expect(form.state.password).toBe("")
    expect(form.state.errors.length).toBe(0)

  it "triggers a LoginActions#authenticate when the login button is clicked", ->
    LoginActions = require("../../actions/login_actions")
    LoginForm = require("../login_form")
    form = @utils.renderIntoDocument(`<LoginForm />`)
    form.setState(email: "email@address.com", password: "pAssword123")

    spyOn(LoginActions, 'authenticate')
    button = @utils.findRenderedDOMComponentWithTag(form, "button").getDOMNode()
    @utils.Simulate.click(button)
    expect(LoginActions.authenticate).toHaveBeenCalledWith("email@address.com", "pAssword123")

  it "listens for success and failure on componentDidMount", ->
    LoginForm = require("../login_form")
    LoginStore = require("../../stores/login_store")
    spyOn(LoginStore, 'addSuccessListener')
    spyOn(LoginStore, 'addFailListener')

    @utils.renderIntoDocument(`<LoginForm />`)
    expect(LoginStore.addSuccessListener).toHaveBeenCalled()
    expect(LoginStore.addFailListener).toHaveBeenCalled()

  it "stops listening to success and failure events on componentWillUnmount", ->
    LoginForm = require("../login_form")
    LoginStore = require("../../stores/login_store")
    spyOn(LoginStore, 'removeSuccessListener')
    spyOn(LoginStore, 'removeFailListener')

    form = @utils.renderIntoDocument(`<LoginForm />`)
    form.componentWillUnmount()
    expect(LoginStore.removeSuccessListener).toHaveBeenCalled()
    expect(LoginStore.removeFailListener).toHaveBeenCalled()

  it "loads authentication errors when auth fails", ->
    LoginForm = require("../login_form")
    LoginStore = require("../../stores/login_store")
    spyOn(LoginStore, 'getLoginErrors')

    form = @utils.renderIntoDocument(`<LoginForm />`)
    form._onLoginFailed()
    expect(LoginStore.getLoginErrors).toHaveBeenCalled()
