module RoutesHelper

  def routes_as_json
    inspector = ActionDispatch::Routing::RoutesInspector.new(raw_routes)
    inspector.format(Formatter.new("routes"))
  end

  private

  class Formatter
    attr_reader :identity

    def initialize(identity)
      @identity = identity

      @buffer = []
      @buffer << "var #{identity} = {};"
    end

    def result
      @buffer.join("\n").html_safe
    end

    def no_routes; end
    def header(routes); end
    def section_title(title); end

    def section(routes)
      named_routes(routes).each do |route|
        @buffer << "#{identity}[\"#{route[:name]}\"] = \"#{route_path(route)}\";"
      end
    end

    private

    def named_routes(routes)
      routes.reject { |route| route[:name].blank? }
    end

    def route_path(route)
      route[:path].sub(/\(.:format\)\z/, "")
    end
  end

  def raw_routes
    Rails.application.routes.routes
  end
end
