module TokenAccessible
  extend ActiveSupport::Concern

  def current_resource_owner
    return unless doorkeeper_token
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def current_application
    return unless doorkeeper_token
    @current_application ||= doorkeeper_token.application
  end
end
