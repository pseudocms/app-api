class Admin::LoginController < ApplicationController
  skip_before_filter :ensure_authed_user

  def index
  end
end
