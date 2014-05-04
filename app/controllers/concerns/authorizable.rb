module Authorizable
  extend ActiveSupport::Concern

  module ClassMethods
    def allow(action, &block)
      before_action only: [action] do
        head(403) unless instance_eval(&block)
      end
    end

    def deny(action, &block)
      before_action only: [action] do
        head(403) if instance_eval(&block)
      end
    end
  end

  def current_user
    return unless doorkeeper_token && doorkeeper_token.resource_owner_id
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def current_application
    return unless doorkeeper_token
    @current_application ||= doorkeeper_token.application
  end

  def account_owner?
    current_user && current_user.id.to_s == params[:id]
  end

  def blessed_app?
    current_application && current_application.blessed?
  end
end
