Rails.application.routes.draw do
  DEVISE_OPTIONS = {
    skip: [:password, :registration],
    path_names: {
      sign_in: 'login', sign_out: 'logout'
    }
  }

  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  scope module: :v1, constrains: ApiConstraints.new('1') do
    devise_for :users, DEVISE_OPTIONS.merge(module: 'v1')
  end
end
