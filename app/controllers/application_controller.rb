require "api/responder"

class ApplicationController < ActionController::API
  self.responder = Api::Responder
  respond_to :json

  include ActionController::ImplicitRender
  include ActionController::StrongParameters
  include Authorizable
  include Paginator

  doorkeeper_for :all

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    render_error("#{controller_name.classify} not found", status: :not_found)
  end

  def render_denied
    render_error("Permission denied", status: :forbidden)
  end

  def render_error(message, status: :internal_service_error)
    error = {
      message: message,
      status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    }
    render json: { errors: error }, status: status
  end
end
