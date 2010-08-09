begin
  require "rubygems"
  require "operawatir"
  require "spec/runner/formatter/base_text_formatter"
rescue LoadError
end

#require "ruby-debug"
#debugger

module OperaWatir
  module Helper
    class << self
      attr_accessor :browser_args, :persistent_browser

      def new_browser
        args = OperaWatir::Helper.browser_args
        args ? OperaWatir::Browser.new(*args) : OperaWatir::Browser.new
      end

      def execute
        defaults
        load_dependencies
        configure
      end

      def configure
        Spec::Runner.configure do |config|
          config.include(PathHelper)

          if OperaWatir::Helper.persistent_browser == false
            config.include(BrowserHelper)

            config.before(:all) do
              @browser = OperaWatir::Helper.new_browser
            end

            config.after(:all) do
              @browser.quit if @browser
            end
          else
            config.include(PersistentBrowserHelper)
            $browser = OperaWatir::Helper.new_browser
            at_exit { $browser.quit }
          end
        end
      end

      def defaults
        OperaWatir::Helper.persistent_browser = false
        files "file://" + File.expand_path(Dir.pwd + "/interactive")
      end

      def files (new_path = nil)
        if new_path
          @files = new_path
        else
          @files
        end
      end

      def load_dependencies
        # Load local helper file, if it exists
        local_helper = "helper.rb"

        if File.exists?(local_helper)
          File.expand_path(File.dirname(local_helper))
          require local_helper
        end

        # Debugger
        #begin
        #  require "ruby-debug"
        #  Debugger.start
        #  Debugger.settings[:autoeval] = true
        #  Debugger.settings[:autolist] = 1
        #rescue LoadError
        #end
      end

      def platform
        @platform ||= case RUBY_PLATFORM
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
    end

    module BrowserHelper
      def browser
        @browser
      end
    end

    module PersistentBrowserHelper
      def browser
        $browser
      end
    end

    module PathHelper
      def files
        OperaWatir::Helper.files
      end
    end
  end
end

class OperaHelperFormatter < Spec::Runner::Formatter::BaseTextFormatter
  def example_failed(example, counter, failure)
#    message = example.description + "\t" + colorize_failure("FAILED", failure) + "\n"
    message = sprintf("%-52s %52s\n", example.description, colorize_failure("FAILED", failure))
    output.puts(message)
    output.flush
  end

  def example_passed(example)
#    message = example.description + "\t" + green("PASSED") + "\n"
    message = sprintf("%-52s %52s\n", example.description, green("PASSED"))
    output.puts(message)
    output.flush
  end

  def example_pending(example, message)
#    message = example.description + "\t" + blue("PENDING") + "\n"
    message = sprintf("%-50s %55s\n", example.description, blue("PENDING"))
    output.puts(message)
    output.flush
  end

#  def start(example_count)
#    puts ""
#    puts "-------------------------------------------------------------------------------------------------"
#    puts "foobar (" + example_count.to_s + " examples)"
#    puts "-------------------------------------------------------------------------------------------------"
#  end

  def example_group_started(example_group_proxy)
    puts ""
    puts "-------------------------------------------------------------------------------------------------"
    puts example_group_proxy.description + " (" + example_group_proxy.examples.size.to_s + " examples)"
    puts "-------------------------------------------------------------------------------------------------"
  end
end

OperaWatir::Helper.execute

