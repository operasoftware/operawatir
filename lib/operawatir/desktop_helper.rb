# -*- coding: utf-8 -*-

# TODO
#   You need to set the OPERA_LAUNCHER and OPERA_PATH environment variables
#   for this Helper to work.

require 'operawatir'
require 'rspec'
require 'rbconfig'
#require 'operawatir/matchers'

RSpec::Matchers.define :load do |expected|
  match do |actual|
    expected == actual
  end
end 

RSpec::Matchers.define :close_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected close_window to close window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :close_dialog do |expected|
  match do |window_id|
    window_id > 0
  end

  failure_message_for_should do |window_id|
    "expected close_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end 

RSpec::Matchers.define :open_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected open_window to open window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :open_dialog do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected open_dialog to close dialog, but window_id returned is not valid: #{window_id}"
  end
end


RSpec::Matchers.define :load_window do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected load... to load in window, but window_id returned is not valid: #{window_id}"
  end
end

RSpec::Matchers.define :load_page do
  match do |actual|
    actual > 0
  end
  
  failure_message_for_should do |window_id|
    "expected load_page to load page, but window_id returned is not valid: #{window_id}"
  end
end

module OperaWatir::DesktopHelper
  extend self
  
  def settings
    OperaWatir::DesktopBrowser.settings
  end
  
  def browser
    @browser ||= OperaWatir::DesktopBrowser.new
  end
  
  def configure_rspec!
    RSpec.configure do |config|
      
      # Set every RSpec option
      settings.each do |key, value|
        config.send("#{key}=", value) if config.respond_to?("#{key}=")
        if key.to_s.eql?("files_to_run")
          @@files = value
        end
      end
            
      config.include SpecHelpers
      
      config.before(:all) {
        if OperaWatir::DesktopHelper::settings[:no_restart] == false
          unless @@files.empty?
            path = File.join(Dir.getwd, @@files.shift)
            filepath = path.chomp(".rb")
            browser.reset_prefs(filepath)
          end
        else
          # Must create browser object here so that none of the
          # test is run before Opera has been launched
          browser
        end
      }

      config.after(:suite) { 
        # Use the @browser directly because we don't want
        # to launch Opera here if it's not running
        if @browser

          if settings[:no_quit] == false
            # Shutdown Opera
            @browser.quit_opera
            @browser.delete_profile
          end

          # Shutdown the driver
          @browser.quit_driver
        end
      }
    end
  end

  def run!(settings={})
    OperaWatir::DesktopBrowser.settings = settings
    configure_rspec!
    RSpec::Core::Runner.autorun
  end
  
private

  module SpecHelpers
    def browser
      OperaWatir::DesktopHelper.browser
    end

    def window
      browser.active_window
    end
  end
end
