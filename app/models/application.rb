class Application < ActiveRecord::Base

  has_many :access_tokens

  validates :name, uniqueness: true, presence: true
  validates :client_id, uniqueness: true, presence: true
  validates :client_secret, presence: true

  before_validation :generate_client_id_and_secret, on: :create

  private

  def generate_client_id_and_secret
    self.client_id = SecureRandom.hex(32)
    self.client_secret = SecureRandom.hex(32)
  end
end
