class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :ensure_authenticated

  private

  def ensure_authenticated
    redirect_to admin_login_path unless valid_token?
  end

  def valid_token?
    auth_token = session[:auth_token]
    return false unless auth_token

    token = Doorkeeper::AccessToken.where(token: auth_token).first
    token && token.accessible?
  end
end
