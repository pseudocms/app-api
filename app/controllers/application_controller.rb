class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :ensure_authed_user

  private

  def ensure_authed_user
    redirect_to admin_login_path unless valid_token?
  end

  def valid_token?
    if auth_token = session[:auth_token]
      token = Doorkeeper::AccessToken.where(token: auth_token).first
      return token && token.accessible?
    end

    false
  end
end
