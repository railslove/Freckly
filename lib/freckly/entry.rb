module Freckly
  class Entry
    class << self
      def all(options = {})
        get_all(options).map {|entry| new(entry) }
      end

      def count(options = {})
         get_all(options).size
      end

      private

      def get_all(options = {})
        results = Freckly.authed_get("/api/entries.xml", :search => options)

        results[:entries] || []
      end
    end

    def initialize(entry_hashie)
      @entry_hashie = entry_hashie
    end

    %w{ billable date description id minutes }.each do |method_name|
      class_eval do
        define_method method_name do
          @entry_hashie.send(method_name)
        end
      end
    end
  end
end