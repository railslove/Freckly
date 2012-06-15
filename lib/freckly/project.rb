module Freckly
  class Project
    class << self
      def all
        get_all.map {|entry| new(entry) }
      end

      def count
         get_all.size
      end

      private

      def get_all
        Freckly.authed_get("/api/projects.xml").projects.map {|project| new(project) }
      end
    end

    def initialize(project_hashie)
      @project_hashie = project_hashie
    end

    def entries(options={})
      Entry.all(options.merge(:projects => id))
    end

    %w{ name id }.each do |method_name|
      class_eval do
        define_method method_name do
          @project_hashie.send(method_name)
        end
      end
    end
  end
end