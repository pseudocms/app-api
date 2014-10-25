Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end

  scope module: :v1, defaults: { format: :json }, constraints: ApiConstraints.new('1', default: true) do
    get '/user', to: 'users#user'
    resources :users, except: [:new, :edit]
    resources :sites, except: [:new, :edit]
  end

  root to: redirect("/admin")

  namespace :admin, constraints: { format: false } do
    root "dashboard#index"

    get "/login", to: "login#index"
    post "/login", to: "login#create"
    delete "/logout", to: "login#destroy"

    resources :sites, only: [:index]
  end
end
