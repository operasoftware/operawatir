begin
  require "rubygems"
  require "operawatir"
  require "spec/runner/formatter/base_text_formatter"
  require "rbconfig"
rescue LoadError
end

#require "ruby-debug"
#debugger

module OperaWatir
  module Helper
    class << self
      attr_accessor :browser_args, :persistent_browser, :files, :inspectr

      # Creates a new browser instance with browser arguments, and
      # starts inspectr if required.
      def new_browser
        args = OperaWatir::Helper.browser_args
        new_browser = args ? OperaWatir::Browser.new(*args) : OperaWatir::Browser.new
        start_inspectr(new_browser.pid) if OperaWatir::Helper.inspectr
        return new_browser
      end

      # OperaHelper wrapper to start OperaWatir.
      def execute
        defaults
        load_dependencies
        configure
      end

      def configure
        Spec::Runner.configure do |config|
          config.include(PathHelper)
          config.include(BrowserHelper)

          if OperaWatir::Helper.persistent_browser == false
            # TODO: Why does :suite fail here?  Getting nil:NilClass if
            # using before/after :suite.
            config.before(:all) do
              @browser = OperaWatir::Helper.new_browser
            end

            config.after(:all) do
              @browser.quit if @browser
            end
          else
            $browser = OperaWatir::Helper.new_browser
            at_exit { $browser.quit }
          end
        end
      end

      # Sets defaults to OperaHelper's configuration options.
      def defaults
        OperaWatir::Helper.browser_args = [] if OperaWatir::Helper.browser_args.nil?
        OperaWatir::Helper.persistent_browser = false
        OperaWatir::Helper.inspectr = false
        OperaWatir::Helper.files = "file://" + File.expand_path(Dir.pwd + "/interactive/")
      end

      # Inititalizes and loads OperaWatir dependencies.
      def load_dependencies
        load_helper
        load_environmental_variables
      end

      # Loads helper file.
      def load_helper
        # Load local helper file, if it exists
        local_helper = "helper.rb"

        if File.exists?(local_helper)
          File.expand_path(File.dirname(local_helper))
          require local_helper
        end
      end

      # Environmental variables (OPERA_PATH, OPERA_ARGS, OPERA_INSPECTR)
      # will overwrite both the default configuration options for
      # OperaHelper as well as the settings from the test suite-specific
      # helper.rb file.
      def load_environmental_variables
        path = ENV["OPERA_PATH"]
        args = ENV["OPERA_ARGS"]
        inspectr = ENV["OPERA_INSPECTR"]

        # Path
        if path.nil? and File.exists?(OperaWatir::Helper.browser_args[0].to_s)
          # OPERA_PATH is not set, but helper path exists
          executable = OperaWatir::Helper.browser_args[0]
          OperaWatir::Helper.browser_args.shift
        elsif not path.nil? and File.exists?(OperaWatir::Helper.browser_args[0].to_s)
          # OPERA_PATH is set, and helper path exists
          executable = path
          OperaWatir::Helper.browser_args.shift
        elsif not path.nil?
          # OPERA_PATH is set
          executable = path
        else
          # OPERA_PATH is not set, helper path does not exist
        end

        # Arguments
        helper_args = OperaWatir::Helper.browser_args
        OperaWatir::Helper.browser_args = [executable] if executable

        args = "" if args.nil?

        if args.size > 0
          args.split(" ").each do |arg|
            OperaWatir::Helper.browser_args.push(arg)
          end
        else
          helper_args.each do |arg|
            OperaWatir::Helper.browser_args.push(arg)
          end
        end

        # inspectr
        OperaWatir::Helper.inspectr = is_true(inspectr) if is_true(inspectr)
      end

      # inspectr is a tool that logs program crashes and freezes.
      #
      # Note that the environmental variable OPERA_INSPECTR takes true
      # (boolean), "true" (string), 1 (integer) and "1" (string) as
      # parameters, while OperaWatir::Helper.inspectr only takes true
      # (boolean).
      def start_inspectr (pid)
        if OperaWatir::Helper.inspectr
          # Find executable for this OS
          inspectr_path = File.expand_path(File.join(File.dirname(__FILE__), "../..", "utils"))

          case platform
          when :linux
            inspectr_path += "/inspectr"
          when :macosx
            inspectr_path += "/inspectr"
          when :windows
            inspectr_path += "/inspectr.exe"
          else
            puts "operahelper: Unable to detect platform!"
            exit
          end

          unless (File.exists?(inspectr_path))
            puts "operahelper: Not able to locate inspectr executable!"
            exit
          end

          # Start inspecting
          Thread.new do
            puts "Starting inspectr on process id #" + pid.to_s
            exec(inspectr_path + " " + pid.to_s)
          end
        end
      end

      # Returns the platform type.
      def platform
        @platform ||= case Config::CONFIG["host_os"]
                      when /java/
                        :java
                      when /mswin|msys|mingw32/
                        :windows
                      when /darwin/
                        :macosx
                      when /linux/
                        :linux
                      else
                        RUBY_PLATFORM
                      end
      end

      # Determines if a configuration file (helper.rb) is true or false.
      # The use might enter “true”, 1 or true.
      def is_true(value)
        if value == true or value == "true" or value == 1 or value == "1"
          true
        elsif value == false or value == "false" or value == 0 or value == "0"
          false
        end
      end
    end

    module BrowserHelper
      def browser
        @browser || $browser
      end
    end

    module PathHelper
      def files (new_path = nil)
        if new_path
          OperaWatir::Helper.files = new_path
        else
          OperaWatir::Helper.files
        end
      end
    end
  end
end

class OperaHelperFormatter < Spec::Runner::Formatter::BaseTextFormatter
  def example_failed(example, counter, failure)
    message = sprintf("%-52s %52s\n", example.description, colorize_failure("FAILED", failure))
    output.puts(message)
    output.flush
  end

  def example_passed(example)
    message = sprintf("%-52s %52s\n", example.description, green("PASSED"))
    output.puts(message)
    output.flush
  end

  def example_pending(example, message)
    message = sprintf("%-50s %55s\n", example.description, blue("PENDING"))
    output.puts(message)
    output.flush
  end

  def example_failed(example, counter, failure)
    message = sprintf("%-52s %52s\n", example.description, colorize_failure("FAILED", failure))
    output.puts(message)
    output.flush
  end

  def example_passed(example)
    message = sprintf("%-52s %52s\n", example.description, green("PASSED"))
    output.puts(message)
    output.flush
  end

  def example_pending(example, message)
    message = sprintf("%-50s %55s\n", example.description, blue("PENDING"))
    output.puts(message)
    output.flush
  end

  def example_group_started(example_group_proxy)
    message = "\n" +
      "-------------------------------------------------------------------------------------------------\n" +
      example_group_proxy.description + " (" + example_group_proxy.examples.size.to_s + " examples)\n" +
      "-------------------------------------------------------------------------------------------------\n"
    output.puts(message)
    output.flush
  end
end

module Spec
  module Runner
    class Options
      def formatters
        @format_options = [["OperaHelperFormatter", @output_stream]]
        @formatters ||= load_formatters(@format_options, EXAMPLE_FORMATTERS)
      end
    end
  end
end

Spec::Runner.options.colour = true
OperaWatir::Helper.execute

