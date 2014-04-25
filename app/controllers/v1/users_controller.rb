module V1
  class UsersController < ApplicationController
    doorkeeper_for :show, scopes: [:trusted_app]

    # GET /user
    def user
      respond_with(current_resource_owner)
    end

    # GET /users/:id
    def show
      user = User.find(params[:id])
      respond_with(user)
    end
  end
end
