Rails.application.assets.context_class.class_eval do
  include RoutesHelper
  include ReactHelper
end
