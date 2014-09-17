class JsRoutes
  def self.render_routes
    routes = Rails.application.routes.routes
    inspector = ActionDispatch::Routing::RoutesInspector.new(routes)
    inspector.format(Formatter.new)
  end
end

require_relative "js_routes/formatter"
