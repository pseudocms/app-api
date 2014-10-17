class Admin::LoginController < ApplicationController
  skip_before_filter :ensure_authed_user

  def index
    @login = Login.new
  end

  def create
    reset_session
    @login = Login.new(login_params)
    return render "index" unless @login.valid?

    user = User.find_for_database_authentication(email: login_params[:email])
    if user && user.valid_password?(login_params[:password])
      token = Doorkeeper::AccessToken.find_or_create_for(
        app_client,
        user.id,
        doorkeeper.default_scopes,
        doorkeeper.access_token_expires_in,
        doorkeeper.refresh_token_enabled?
      )

      session[:auth_token] = token.token
    else
      @login.errors.add(:base, "Invalid login credentials")
      render "index"
    end
  end

  def destroy
    reset_session
  end

  private

  def login_params
    @login_params ||= params.require(:login).permit(:email, :password)
  end

  def app_client
    @app_client ||= begin
      config = Rails.application.config_for(:application)
      Doorkeeper::Application.find_by_uid_and_secret(config["client_id"], config["client_secret"])
    end
  end

  def doorkeeper
    Doorkeeper.configuration
  end
end
