module V1
  class UsersController < ApplicationController
    doorkeeper_for :index, :show, :create, scopes: [:trusted_app]

    # GET /users
    def index
      respond_with(User.all)
    end

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
      user = User.create(user_params)
      respond_with(user, location: user)
    end

    # PATCH /users/:id
    # PUT /users/:id
    def update
      user = current_resource_owner
      user = User.find(params[:id]) if trusted_app?

      if trusted_app? || account_owner?
        user.update_attributes(user_params)
        respond_with(user)
      else
        head 401
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def trusted_app?
      doorkeeper_token.scopes.include?('trusted_app')
    end

    def account_owner?
      current_resource_owner.id.to_s == params[:id]
    end
  end
end
