require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "freckly"
    gem.summary = %Q{Freckle Gem}
    gem.description = %Q{Freckle Gem}
    gem.email = "reddavis@gmail.com"
    gem.homepage = "http://github.com/reddavis/freckly"
    gem.authors = ["reddavis"]
    gem.add_development_dependency("rspec", "~> 1.3.0")
    gem.add_runtime_dependency("faraday", "~> 0.4.6")
    gem.add_runtime_dependency("faraday_middleware", "~> 0.1.0")
    gem.add_runtime_dependency("multi_xml", "~> 0.0.1")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.ruby_opts = ["-I spec/", "-rubygems"]
  puts FileList['spec/**/*_spec.rb'].inspect
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec