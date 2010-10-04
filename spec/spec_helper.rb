$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'freckly'

gem "rspec", "1.3.0"
require 'spec'
require 'spec/autorun'
require 'webmock/rspec'

def fixture(file_name)
  File.read(File.expand_path(File.dirname(__FILE__) + "/fixtures/#{file_name}"))
end

Spec::Runner.configure do |config|
  config.include WebMock
end