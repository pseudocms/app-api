module V1
  class UsersController < ApplicationController
    doorkeeper_for :show, :create, scopes: [:trusted_app]

    # GET /user
    def user
      respond_with(current_resource_owner)
    end

    # GET /users/:id
    def show
      user = User.find(params[:id])
      respond_with(user)
    end

    # POST /users
    def create
      user = User.create(create_params)
      respond_with(user, location: user)
    end

    private

    def create_params
      params.require(:user).permit(:email, :password)
    end
  end
end
