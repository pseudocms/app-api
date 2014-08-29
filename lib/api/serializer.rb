module Api
  class Serializer

    class << self
      attr_accessor :_attributes, :_associations, :_condensed_attributes

      def inherited(base)
        base._attributes = (_attributes || []).dup
        base._condensed_attributes = (_condensed_attributes || [:id]).dup
        base._associations = (_associations || {}).dup
      end

      def attributes(*attrs)
        _attributes.concat(attrs)
      end

      def condensed_attributes(*attrs)
        _condensed_attributes.concat(attrs)
      end

      def belongs_to(attr, options = {})
        _associations[attr] = options
      end

      def for(instance)
        serializer_name = "#{instance.class.name}Serializer"
        Object.const_get(serializer_name).new(instance) if exists?(serializer_name)
      end

      private

      def exists?(serializer_name)
        begin
          Object.const_get(serializer_name)
        rescue NameError
        end

        Object.const_defined?(serializer_name)
      end
    end

    attr_reader :model

    def initialize(model)
      @model = model
    end

    def as_json(options = {})
      result = {}
      if options[:condensed]
        result.merge!(condensed_attrs)
      else
        result.merge!(expanded_attrs)
        result.merge!(association_attrs)
      end

      result.as_json
    end

    private

    def expanded_attrs
      attr_hash(self.class._attributes)
    end

    def condensed_attrs
      attr_hash(self.class._condensed_attributes)
    end

    def association_attrs
      self.class._associations.inject({}) do |hash, attr|
        params = attr.last.dup
        params[:condensed] = params.delete(:expanded).nil?
        hash[attr.first] = attr_value(attr.first, params)
        hash
      end
    end

    def attr_value(attr, options = {})
      model.public_send(attr).try(:as_json, options)
    end

    def attr_hash(attrs)
      attrs.inject({}) { |hash, attr| hash[attr] = attr_value(attr); hash }
    end
  end
end
