$LOAD_PATH.unshift File.dirname(__FILE__)
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bundler'
# TODO Bundler.read(bundlefile)
Bundler.require :spec

require 'watirspec'
require 'guards'
require 'server'

require 'operawatir'
require 'operawatir/spec_runner'

# include OperaWatir::Exceptions

# WatirSpec.browser do |b|
#   b.name   = :opera
#   b.driver = OperaWatir::Browser
# end

OperaWatir::SpecRunner.run!

RSpec.configure do |config|
  config.include WatirSpec::Guard::Helpers
  
  config.before(:suite) do
    Thread.new { WatirSpec::Server.run! }
  end
end



# 
# # 
# WatirSpec::Runner.execute
