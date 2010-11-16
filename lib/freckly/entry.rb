module Freckly
  class Entry
    class << self
      def all(options={})
        results = Freckly.authed_get("/api/entries.xml", :search => options)

        if entries = results[:entries]
          entries.map {|entry| new(entry) }
        else
          []
        end
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