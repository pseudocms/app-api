module V1
  class UsersController < ApplicationController

    def show
      respond_with(current_resource_owner)
    end
  end
end
