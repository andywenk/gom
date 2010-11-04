
module GOM

  module Object

    # Inspect an object and returns it's class and it's properties
    class Inspector

      attr_reader :object
      attr_reader :object_hash

      def initialize(object)
        @object = object
        @object_hash = { }
      end

      def perform
        read_class
        read_properties
      end

      private

      def read_class
        @object_hash[:class] = @object.class.to_s
      end

      def read_properties
        @object_hash[:properties] = { }
        @object.instance_variables.each do |name|
          key = name.to_s.sub(/^@/, "").to_sym
          @object_hash[:properties][key] = @object.instance_variable_get(name)
        end
      end

    end

  end

end
