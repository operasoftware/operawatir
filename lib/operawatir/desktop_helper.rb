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
    puts "Get browser object"
    @browser ||= OperaWatir::DesktopBrowser.new
  end
  
  def configure_rspec!
    RSpec.configure do |config|
      
      # Set every RSpec option
      settings.each do |key, value|
        config.send("#{key}=", value) if config.respond_to?("#{key}=")
      end
            
      config.include SpecHelpers
      
      config.after(:suite) { 
        puts "config after suite"
        if @browser
          # Check if we shutdown Opera or just the driver
          
          
          # Quit Opera unless we have forced it to stay up
        #  if OperaWatir::DesktopBrowser.settings[:no_quit] == false
           # browser.quit_opera
         # end
          puts "about to quit"
          # Shutdown the driver
          @browser.quit_driver
        end

        #browser.quit! if browser 
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
