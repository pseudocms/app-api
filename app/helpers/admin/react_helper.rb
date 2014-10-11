module Admin
  module ReactHelper

    def react(&block)
      id = react_component_id
      component = Reactor.compile(capture(&block))
      content_tag :div, react_register_script(id, component), id: id
    end

    private

    def react_component_id
      "react-#{SecureRandom.hex(6)}"
    end

    def react_register_script(id, component_code)
      script = <<-SCRIPT
      var reactComponents = reactComponents || [];
      reactComponents.push({ id: "#{id}", component: "#{Base64.strict_encode64(component_code)}" });
      SCRIPT

      javascript_tag(script).html_safe
    end
  end
end
