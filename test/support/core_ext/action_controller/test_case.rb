class ActionController::TestCase

  attr_reader :current_access_token

  def login_as_user
    app = create(:application)
    user = create(:user, password: "pAssword123")

    login = Login.new(
      email: user.email,
      password: "pAssword123",
      application: app
    )

    token = login.find_or_create_token
    raise "No Token" unless token.present?

    @current_access_token = token
    cookies[:access_token] = token.token
  end

  def logout
    cookies.delete(:access_token)
    current_access_token.destroy unless current_access_token.nil?
  end
end
