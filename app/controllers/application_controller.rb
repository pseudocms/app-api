class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters
  include Authorizable
  include Paginator

  respond_to :json
  doorkeeper_for :all

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found
    head(:not_found)
  end
end
