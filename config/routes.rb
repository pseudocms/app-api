Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  def devise_options
    {
      skip: [:password, :registration],
      path_names: {
        sign_in: 'login', sign_out: 'logout'
      }
    }
  end

  scope module: :v1, defaults: { format: :json }, constraints: ApiConstraints.new('1', default: true) do
    get '/user', to: 'users#user'
    resources :users, except: [:new, :edit]
    resources :sites, except: [:new, :edit]
  end

  namespace :admin do
    root "dashboard#index"
    get "/login", to: "login#index"
  end
end
