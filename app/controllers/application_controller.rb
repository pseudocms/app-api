class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters
  include Authorizable
  include Paginator

  respond_to :json
  doorkeeper_for :all
end
