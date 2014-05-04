module V1
  class UsersController < ApplicationController
    allow(:index)  { current_user.nil? && blessed_app? }
    allow(:user)   { current_user }
    allow(:show)   { blessed_app? || account_owner? }
    allow(:update) { account_owner? || blessed_app? }
    deny(:create)  { current_user || !blessed_app? }

    # GET /users
    def index
      respond_with(paginate(User.all))
    end

    # GET /user
    def user
      respond_with(current_user)
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
      user = User.find(params[:id])
      user.update_attributes(user_params)
      respond_with(user)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
