module ReactHelper

  def react_component(name)
    id = react_component_id
    script = javascript_tag(react_register_script(id, name)).html_safe
    content_tag :div, script, id: id
  end

  def react_components
    Dir["#{Rails.root}/app/assets/javascripts/components/**/*.js.jsx"].map do |file|
      "./components#{file.gsub(/(\A.*components|\.js\.jsx\z)/, "")}"
    end
  end

  def components_as_json
    buffer = []
    buffer << "var components = {};"
    react_components.each do |js_module|
      name = File.basename(js_module).camelize
      buffer << "components[\"#{name}\"] = require(\"#{js_module}\");"
    end

    buffer.join("\n")
  end

  private

  def react_component_id
    "react-#{SecureRandom.hex(6)}"
  end

  def react_register_script(id, name)
    script = <<-EOL
    var reactComponents = reactComponents || {}
    reactComponents["#{id}"] = "#{name}"
    EOL
  end
end
