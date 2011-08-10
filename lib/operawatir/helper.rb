# -*- coding: utf-8 -*-

# TODO
#   You need to set the OPERA_LAUNCHER and OPERA_PATH environment variables
#   for this Helper to work.

require 'operawatir'
require 'rspec'
require 'rbconfig'

module OperaWatir::Helper
  extend self

  def settings
    OperaWatir::Browser.settings
  end

  def browser
    @browser ||= OperaWatir::Browser.new
  end

  def configure_rspec!
    RSpec.configure do |config|

      # Set every RSpec option
      settings.each do |key, value|
        config.send("#{key}=", value) if config.respond_to?("#{key}=")
      end

      config.include SpecHelpers

      config.after(:suite) do
        browser.quit if @browser
        abort
      end
    end
  end

  def run!(settings={})
    OperaWatir::Browser.settings = settings
    configure_rspec!
    RSpec::Core::Runner.autorun
  end

private

  module SpecHelpers
    def browser
      OperaWatir::Helper.browser
    end

    def window
      browser.active_window
    end
  end
end

OperaWatir::Helper.run!
