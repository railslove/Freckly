module Freckly
  class Entry
    class << self
      def find_all_for_project(project_ids, options={})
        Freckly.authed_get("/api/entries.xml", options.merge(:projects => project_ids))[:entries].map {|entry| new(entry) }
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