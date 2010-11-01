# -*- coding: utf-8 -*-

require 'rspec'
require 'rbconfig'

class Object
  def truthy?

    # FIXME: Should we not check for truthfulness instead, and presume
    # that anything else passed to be false?  Below we are doing the
    # opposite.
    #self && !['false', 'no', 'n', '0', 0].include?(self)

    self && [true, 'true', 'yes', 'y', '1', 1].include?(self)
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

  # TODO: Make nice configuration block
  def self.configure
    yield configuration if block_given?
  end

  # FIXME: These accessor settings are parsed procedurally, is this what we want?
  default_attr_accessor :path,          nil
  default_attr_accessor :args,          ''
  default_attr_accessor :files,         "file://localhost/#{File.expand_path('interactive', File.dirname(RSpec.configuration.files_to_run[0]))}/"
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
              (Config::CONFIG['os_host'] =~ /mswin|msys|mingw32/ ? 'inspectr.exe' : 'inspectr')
  end
  
  def spawn_inspectr
    abort 'operawatir: inspectr is not supported on your operating system' unless Config::CONFIG['os_host'] =~ /linux/
    abort 'operawatir: Unable to locate inspectr executable' unless File.exist?(inspectr_path)
    
    Thread.new do
      puts "Attaching inspectr to PID ##{browser.pid}"
      exec inspectr_path, browser.pid.to_s
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
    alias_method :files=, :files
  end
end
