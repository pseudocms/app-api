require "test_helper"

class LoginFormBuilderTest < ActionView::TestCase

  test "form_field creates a FormField component" do
    field = builder.form_field(:email)
    assert_includes field, "<FormField"
  end

  test "form_field copies options as props for the FormField component" do
    field = builder.form_field(:email, type: "email", className: "input", label: "My Field")
    expectations = %w(
      type="email"
      className="input"
      label="My Field"
      name="login[email]"
    )

    expectations.each { |substr| assert_includes field, substr }
  end

  test "form_field renders a password field when type is password" do
    field = builder.form_field(:password, type: "password", className: "input", label: "My Field")
    assert_includes field, %Q{type="password"}
  end

  private

  def model
    @model ||= Login.new
  end

  def builder
    @builder ||= begin
      LoginFormBuilder.new(:login, model, template, {})
    end
  end

  def template
    @template ||= begin
      template = Object.new
      template.extend(ActionView::Helpers::FormHelper)
      template.extend(ActionView::Helpers::FormOptionsHelper)
      template
    end
  end

end
