# -*- coding: utf-8 -*-
require 'rspec'

class Object
  
  # Determines if a configuration file (helper.rb) is true or false. The user 
  # might enter “true”, 1 or true.
  def truthy?
    self && !['false', 'no', 'n', '0', 0].include?(self)
  end
end


module OperaWatir::Waiter
  extend self
  
  def self.default_attr_accessor(attr, default)
    define_method attr.to_sym do
      ENV["OPERA_#{attr.to_s.upcase}"] || instance_variable_get("@#{attr}") || default
    end
    attr_writer attr.to_sym
  end
  
  default_attr_accessor :path,          nil
  default_attr_accessor :args,          ''
  default_attr_accessor :files,         "file://#{File.expand_path('../interactive', Dir.pwd)}"
  default_attr_accessor :inspectr,      false
  default_attr_accessor :terminal_size, [80,24]
  
  def browser
    @browser ||= OperaWatir::Browser.new(path, *args.split(' '))
  end
  
  def helper_file
    File.expand_path(File.join(Dir.pwd, 'helper.rb'))
  end
  
  def configure_rspec
    RSpec.configure do |config|
      config.include SpecHelpers
      config.after(:suite) do
        OperaWatir::Waiter.browser.quit
      end
    end
  end
  
  def inspectr_path
    File.join File.expand_path('../../../utils', __FILE__),
              (RUBY_PLATFORM =~ /mswin|msys|mingw32/ ? 'inspectr.exe' : 'inspectr')
  end
  
  def spawn_inspectr
    abort 'operahelper: Unable to locate inspectr executable' unless File.exist?(inspectr_path)
    
    Thread.new do
      puts "Starting inspectr with PID ##{browser.pid}"
      exec inspectr, browser.pid.to_s
    end
  end

  def run!
    require helper_file if File.exist?(helper_file)
    spawn_inspectr if inspectr.truthy?
    configure_rspec
  end
  
  # Helpers included for each Spec
  
  module SpecHelpers
    def browser
      OperaWatir::Waiter.browser
    end

    # TODO Not sure of this
    def files(new_path=nil)
      if new_path
        OperaWatir::Waiter.files = new_path
      else
        OperaWatir::Waiter.files
      end
    end
  end

end
