class Admin::LoginController < ApplicationController
  skip_before_action :ensure_authenticated

  def index
  end

  def create
    reset_session
    session[:auth_token] = params[:token]
    redirect_to admin_root_path
  end

  def destroy
    reset_session
    redirect_to admin_login_path
  end
end