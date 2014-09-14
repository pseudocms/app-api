module Api
  class Responder < ActionController::Responder
    include Responders::HttpCacheResponder
  end
end
