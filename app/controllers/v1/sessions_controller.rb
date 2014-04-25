module V1
  class SessionsController < Devise::SessionsController
    include Devise::Controllers::Helpers

    def create
      resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      resource.reset_auth_token

      render json: {
        auth_token: resource.auth_token
      }
    end
  end
end
