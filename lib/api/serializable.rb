module Api
  module Serializable
    extend ActiveSupport::Concern

    def as_json(options = {})
      if serializer = Serializer.for(self)
        serializer.as_json(options)
      else
        super
      end
    end
  end
end
