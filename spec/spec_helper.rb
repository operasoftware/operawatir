$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", "lib")
require "operawatir"
require "spec/watirspec/spec_helper"

include OperaWatir::Exceptions
include OperaWatir

WatirSpec.implementation do |browser|
  browser.name          = :opera
  browser.browser_class = OperaWatir::Browser
  browser.guard_proc = lambda do |guards|
    guards.any? {|guard| [:watir, :opera].include?(guard)}
  end

end

WatirSpec::SpecHelper.execute

