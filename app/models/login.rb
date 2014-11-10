class Login
  include ActiveModel
  include ActiveModel::Validations

  attr_reader :email, :password, :application

  validates :email, format: { with: Formats::EMAIL, message: "must be a valid email address" }
  validates_presence_of :password
  validates_presence_of :application

  def initialize(attrs = {})
    attrs.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end

  def persisted?
    false
  end

  def to_key
    [1]
  end

  def find_or_create_token
    return nil unless valid?

    user = User.find_for_database_authentication(email: email)
    return nil unless user && user.valid_password?(password)

    app_tokens = user.access_tokens.where(application_id: application.id)

    if token = app_tokens.find { |t| t.accessible? }
      token
    else
      user.access_tokens.create!(application: application)
    end
  end
end
