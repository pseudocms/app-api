class Admin::LoginController < ApplicationController
  skip_before_filter :ensure_authed_user

  def index
    @login = Login.new(application: app_from_params)
  end

  def create
    @login = Login.new(login_params.merge(application: app_from_params))

    if token = @login.find_or_create_token
      reset_session
      cookies[:access_token] = token.token
      redirect_to admin_root_path
    else
      @login.errors.add(:base, "Invalid email and/or password")
      render :index
    end
  end

  def destroy
    reset_session
    cookies.delete(:access_token)
    redirect_to admin_root_path
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end

  def app_from_params
    app_params = params.permit(:client_id, :client_secret)
    if app_params.empty?
      config = Rails.application.config_for(:application)
      app_params = {
        client_id: config["client_id"],
        client_secret: config["client_secret"]
      }
    end

    Application.find_by_client_id_and_client_secret(app_params[:client_id], app_params[:client_secret])
  end
end
