class User < ActiveRecord::Base
  before_save :ensure_auth_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def reset_auth_token
    update_column(:auth_token, generate_auth_token)
  end

  private

  def ensure_auth_token
    self.auth_token = generate_auth_token if auth_token.blank?
  end

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end
end
