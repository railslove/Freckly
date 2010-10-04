module Freckly
  class Project
    class << self
      def all
        Freckly.authed_get("/api/projects.xml").projects.map {|project| new(project) }
      end
    end

    def initialize(project_hashie)
      @project_hashie = project_hashie
    end

    def entries(options={})
      Entry.find_all_for_project(id, options)
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