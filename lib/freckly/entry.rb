module Freckly
  class Entry
    class << self
      def all(options={})
        options = commatorize_params(options)
        Freckly.authed_get("/api/entries.xml", options)[:entries].map {|entry| new(entry) }
      end

      private

      def commatorize_params(params)
        params.each_pair do |key, value|
          next unless value.is_a?(Array)

          params[key] = value.join(",")
        end

        params
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