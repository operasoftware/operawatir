$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Bundler.require :spec

require File.expand_path('../watirspec/spec_helper', __FILE__)

require 'operawatir'

WatirSpec.browser do |b|
  b.name   = :opera
  b.driver = OperaWatir::Browser
end

WatirSpec::Runner.execute
