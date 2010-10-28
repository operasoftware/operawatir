$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'watirspec'
require 'guards'
require 'server'

require 'operawatir/helper'

include OperaWatir::Exceptions

include WatirSpec::Guard::Helpers

RSpec.configure do |config|
  config.include WatirSpec::Helpers
  
  config.before(:suite) do
    Thread.new { WatirSpec::Server.run! }
  end
end
