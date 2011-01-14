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
      end
            
      config.include SpecHelpers
      
      config.before(:all) {
        #This will quit opera, copy prefs and restart
       # browser.reset_prefs
          # Create the browser object here
          browser
          
          # Preference stuff
          puts "Do Preference stuff"
      }

      config.after(:suite) { 
        puts "config after suite"
        if @browser

          if settings[:no_quit] == false
            # Shutdown Opera
            puts "Quit Opera!"
            @browser.quit_opera
          end

          # Shutdown the driver
          puts "Quit OperaWatir!"
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
      OperaWatir::Helper.browser
    end

    def window
      browser.active_window
    end
  end
end
