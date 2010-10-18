require 'rubygems'
require 'operawatir'
require 'rbconfig'

#require 'rspec/core/formatters/base_text_formatter'
#require File.expand_pah(File.dirname(__FILE__) + '../../../utils/formatters/operahelper_formatter.rb')

require File.join File.expand_path('../../../utils/formatters/operahelper_formatter.rb', __FILE__)

class Object
  # Determines if a configuration file (helper.rb) is true or false.  The use
  # might enter “true”, 1 or true.
  def truthy?
    self && !['false', 'no', '0', 0].include?(self)
  end
end

#module OperaWatir::SpecRunner
module OperaWatir::Helper
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
    @browser ||= OperaWatir::Browser.new(path, *args.split(' '))  # FIXME: split?
  end

  def helper_file
    File.expand_path(File.join(Dir.pwd, 'helper.rb'))
  end

  def configure_rspec
    #RSpec.configure do |config|
    Spec::Runner.configure do |config|
      config.include Helpers

      config.after(:suite) do
        OperaWatir::Helper.browser.quit
      end
    end
  end

  def inspectr_path
    # This must change at some point, because we will have different executables for
    # Mac OS X, GNU/Linux and Windows.
    File.join File.expand_path('../../../utils', __FILE__),
              (platform == :windows ? 'inspectr.exe' : 'inspectr')
  end

  def spawn_inspectr
    abort 'operahelper: Unable to locate inspectr executable' unless File.exist?(inspectr_path)

    Thread.new do
      puts "Starting inspectr with PID ##{browser.pid}"
      exec inspectr, browser.pid.to_s
    end
  end

  def platform
    @platform ||= case Config::CONFIG['host_os']
                  #when /java/
                  #  :java
                  when /mswin|msys|mingw32/
                    :windows
                  when /darwin/
                    :macosx
                  when /linux/
                    :linux
                  else
                    Config::CONFIG['host_os'] || RUBY_PLATFORM
                  end
  end

  def run!
    require helper_file if File.exist?(helper_file)
    spawn_inspectr if inspectr.truthy?
    configure_rspec
  end

  # Helpers included for each test.
  module Helpers
    def browser
      OperaWatir::Helper.browser
    end

    def files(new_path=nil)
      if new_path
        OperaWatir::Helper.files = new_path
      else
        OperaWatir::Helper.files
      end
    end
  end
end

class Spec::Runner::Options
  def formatters
    @format_options = [['OperaHelperFormatter', @output_stream]] if @format_options.nil?
    @formatters ||= load_formatters(@format_options, EXAMPLE_FORMATTERS)
  end
end

OperaWatir::Helper.run!

