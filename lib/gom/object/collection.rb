
module GOM

  module Object

    # A class for a collection of objects.
    class Collection

      def initialize(fetcher)
        @fetcher = fetcher
      end

      def total_count
        @fetcher.total_count
      end

      def method_missing(method_name, *arguments, &block)
        load_object_proxies
        @object_proxies.send method_name, *arguments, &block
      end

      private

      def load_object_proxies
        @object_proxies ||= begin
          if @fetcher.object_hashes
            @fetcher.object_hashes.map do |object_hash|
              GOM::Object::Proxy.new GOM::Object::CachedBuilder.new(object_hash).object
            end
          elsif @fetcher.ids
            @fetcher.ids.map do |id|
              GOM::Object::Proxy.new id
            end
          else
            raise NotImplementedError, "the collection fetcher doesn't provide object hashes nor ids."
          end
        end
      end

    end

  end

end
