###* @jsx React.DOM ###

@LoginForm = React.createClass
  render: ->
    `(
      <section className="card card--login">
        <header className="card__header">
          <h1><i className="fa fa-lock"></i>Please Login</h1>
        </header>
        <section className="card__content">
          <div className="form">
            <div className="form__field">
              <label className="form__label" htmlFor="email">Email:</label>
              <input className="form__input" type="email" name="email" placeholder="user@example.com" />
            </div>
            <div className="form__field">
              <label className="form__label" htmlFor="password">Password:</label>
              <input className="form__input" type="password" name="password" />
            </div>
            <div className="form__field--actions">
              <button className="btn">Login</button>
            </div>
          </div>
        </section>
      </section>
    )`
