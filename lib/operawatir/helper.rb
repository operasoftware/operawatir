# -*- coding: utf-8 -*-

# You need to set the OPERA_LAUNCHER and OPERA_PATH environment variables
# for this Helper to work.

require 'operawatir'
require 'rspec'
require 'rbconfig'
require 'ostruct'

module OperaWatir::Helper
  extend self

  def configure(&block)
    OperaWatir::SettingsHelper.block_to_hash(block).each do |setting, value|
      self.class.send(:define_method, setting.to_sym) do
        value.to_s || instance_variable_get("@#{attr}")
      end
    end
  end

  def browser
    @browser ||= new_browser_instance
  end

  def new_browser_instance
    settings = OperaWatir::Settings.new do |config|
      config.launcher = ENV['OPERA_LAUNCHER']
      config.path = ENV['OPERA_PATH']
      config.args = ''
    end

    OperaWatir::Browser.new(settings.driver_settings)
  end

  def helper_file
    File.expand_path(File.join(Dir.pwd, 'helper.rb'))
  end

  def configure_rspec
    RSpec.configure do |config|
      config.include SpecHelpers

      config.after(:suite) do
        @browser.quit!
      end
    end
  end

  def run!
    require helper_file if File.exist?(helper_file)
    configure_rspec
    RSpec::Core::Runner.autorun
  end


  # Helpers included for each Spec

  module SpecHelpers
    def browser
      OperaWatir::Helper.browser
    end

    def window
      browser.active_window
    end

    # TODO Not sure of this
    def files(new_path=nil)
      if new_path
        OperaWatir::Helper.files = new_path
      else
        OperaWatir::Helper.files
      end
    end
    alias_method :files=, :files
  end
end

# Overriding trapping in RSpec.
module RSpec
  module Core
    class Runner
      def self.trap_interrupt; end
    end
  end
end

OperaWatir::Helper.run!
