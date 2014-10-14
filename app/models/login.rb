class Login
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :email, :password

  validates :email, format: { with: Formats::EMAIL, message: "must be a valid email address" }
  validates_presence_of :password

  def initialize(attrs = {})
    attrs.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end

  def persisted?
    false
  end
end
