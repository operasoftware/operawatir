$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rr
end
