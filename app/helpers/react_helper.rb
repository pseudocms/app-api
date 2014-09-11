module ReactHelper

  def react_component(name)
    id = react_component_id
    script = javascript_tag(react_register_script(id, name)).html_safe
    content_tag :div, script, id: id
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
