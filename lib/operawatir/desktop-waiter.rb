# -*- coding: utf-8 -*-

require 'rspec'
require 'rbconfig'
require 'ostruct'

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
      default || instance_variable_get("@#{attr}") || ENV["OPERA_#{attr.to_s.upcase}"]
    end
    attr_writer attr.to_sym
  end

  def defaults
    configure do |c|
      c.path          = nil
      c.args          = ''
      c.files         = "file://localhost/#{File.expand_path('interactive', File.dirname(RSpec.configuration.files_to_run[0]))}"
      c.inspectr      = false
      c.terminal_size = [80,24]
    end
  end

  def configure(*args, &block)
    HelperConfig.block_to_hash(block).each do |setting, value|
      default_attr_accessor setting, value
    end
  end

  class HelperConfig < OpenStruct
    def self.block_to_hash(block=nil)
      config = self.new
      if block
        block.call(config)
        config.to_hash
      else
        {}
      end
    end
    
    def to_hash
      @table
    end
  end

  defaults

  def browser
    @browser ||= OperaWatir::DesktopBrowser.new(path, *args.split(' ').to_java(:string))
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
              (Config::CONFIG['host_os'] =~ /mswin|msys|mingw32/ ? 'inspectr.exe' : 'inspectr')
  end
  
  def spawn_inspectr
    abort 'operawatir: inspectr is not supported on your operating system' unless Config::CONFIG['host_os'] =~ /linux/
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
    RSpec::Core::Runner.autorun
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

# Overriding trapping in RSpec.
module RSpec
  module Core
    class Runner
      def self.trap_interrupt; end
    end
  end
end
=begin
def remove_prefs_folders
    get_opera_preferences_paths.each do |folder|
      if File.directory?(folder)
        Dir.rmdir(folder)
      end
    end
  end
  
  #paths contains the folders to copy
  #get_opera_preferences_paths gives where to copy them
  def copy_prefs_folders(paths)
    paths.each do | path |
      
    end
  end
=end