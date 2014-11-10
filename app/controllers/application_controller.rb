class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :ensure_authed_user
  helper_method :access_token

  private

  def access_token
    cookies[:access_token]
  end

  def ensure_authed_user
    redirect_to admin_login_path unless valid_token?
  end

  def valid_token?
    if access_token.present?
      token = AccessToken.by_token(access_token)
      return token && token.accessible?
    end

    false
  end
end
