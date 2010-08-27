$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'operawatir'
require 'spec/watirspec/spec_helper'

WatirSpec.implementation do |browser|
  browser.name          = :opera
  browser.browser_class = OperaWatir::Browser
end

WatirSpec::SpecHelper.execute
