class LoginFormBuilder < ActionView::Helpers::FormBuilder

  def form_field(method, options = {})
    options[:className] += " invalid" if has_error?(method)

    input = case options[:type]
            when "password"
              password_field(method, options)
            else
              text_field(method, options)
            end

    input.sub(/<input/, "<FormField").html_safe
  end

  private

  def has_error?(attr)
    @object.errors.present? && @object.errors.has_key?(attr)
  end
end
