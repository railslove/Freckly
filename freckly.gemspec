# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "freckly/version"

Gem::Specification.new do |s|
  s.name        = "freckly"
  s.version     = Freckly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Red Davis"]
  s.email       = ["red@railslove.com"]
  s.homepage    = "http://rubygems.org/gems/freckly"
  s.summary     = %q{Wrapper for Freckle}
  s.description = %q{Wrapper for Freckle}

  s.rubyforge_project = "freckly"

  s.add_dependency "faraday", "~> 0.5.7"
  s.add_dependency "faraday_middleware", "~> 0.3.0"
  s.add_dependency "multi_xml", "~> 0.2.0"
  s.add_dependency "hashie", "~> 0.4.0"

  s.add_development_dependency "rspec", "~> 2.1.0"
  s.add_development_dependency "webmock", "~> 1.6.1"
  s.add_development_dependency "rake", "~> 0.8.7"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
