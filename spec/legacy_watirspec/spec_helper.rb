require File.expand_path("../watirspec_helper", __FILE__)

#OperaWatir.compatibility!

module LegacyWatirSpecHelpers
  def browser
    OperaWatir::Helper::BrowserHelper.browser
  end
end

RSpec.configure do |config|
  config.include OperaWatir::Helper::BrowserHelper
end
