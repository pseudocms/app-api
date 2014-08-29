require_relative "api/serializable"
require_relative "api/serializer"

ActiveSupport.on_load(:active_record) do
  include Api::Serializable
end
