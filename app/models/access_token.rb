class AccessToken < ActiveRecord::Base
  belongs_to :application
  belongs_to :user

  before_validation :set_created_at, :generate_token, on: :create

  def self.by_token(token)
    where(token: token).first
  end

  def revoke
    update_attribute(:revoked_at, DateTime.now)
  end

  def accessible?
    !(revoked? || expired?)
  end

  def expired?
    return false unless expires_in > 0
    Time.now > (created_at + expires_in.seconds)
  end

  def revoked?
    revoked_at.present?
  end

  private

  def set_created_at
    self.created_at = DateTime.now
  end

  def generate_token
    self.token = SecureRandom.hex(32)
  end
end
