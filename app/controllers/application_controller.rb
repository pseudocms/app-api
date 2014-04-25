class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters

  respond_to :json
  doorkeeper_for :all

  protected

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
