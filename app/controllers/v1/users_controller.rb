module V1
  class UsersController < ApplicationController
    allow(:index)   { blessed_app? }
    allow(:user)    { current_user }
    allow(:show)    { blessed_app? || account_owner? }
    allow(:update)  { account_owner? || blessed_app? }
    allow(:create)  { blessed_app? }
    allow(:destroy) { blessed_app? }

    # GET /users
    def index
      users = paginate(User.all, users_url)
      respond_with(users)
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

    # DELETE /users/:id
    def destroy
      user = User.find(params[:id])
      user.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
