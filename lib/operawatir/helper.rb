# -*- coding: utf-8 -*-

# TODO
#   You need to set the OPERA_LAUNCHER and OPERA_PATH environment variables
#   for this Helper to work.

require 'operawatir'
require 'rspec'
require 'rbconfig'

module OperaWatir::Helper
  extend self
  
  attr_accessor :options
  
  def browser
    @browser ||= OperaWatir::Browser.new(options)
  end
  
  def helper_path
    File.expand_path(File.join(Dir.pwd, 'helper.rb'))
  end

  def configure_rspec!
    RSpec.configure do |config|
      config.color_enabled = options[:color]
      config.formatter     = options[:format]
      config.files_to_run  = options[:files]
      
      config.include SpecHelpers
      
      config.after(:suite) {browser.quit! if browser}
    end
  end

  def run!(options={})
    self.options = options
    require helper_path if File.exist?(helper_path)
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
