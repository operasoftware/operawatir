$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Bundler.require :spec

require 'operawatir'
require 'spec/watirspec/spec_helper'

include OperaWatir
include OperaWatir::Exceptions

WatirSpec.implementation do |browser|
  browser.name          = :opera
  browser.browser_class = OperaWatir::Browser
  
  browser.guard_proc    = lambda do |guards|
    guards.any? {|guard| [:watir, :opera].include?(guard)}
  end
end

WatirSpec::Runner.execute
