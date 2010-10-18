# OperaHelperFormatter is intended for use with OperaHelper, which can
# be loaded using
#
#   require "operawatir/helper"
#
# in your RSpec test suite.

require 'spec/runner/formatter/base_text_formatter'

class OperaHelperFormatter < Spec::Runner::Formatter::BaseTextFormatter
  def example_failed (example, counter, failure)
    output.puts message example, colorize_failure('FAILED', failure)
    output.flush
  end

  def example_passed (example)
    output.puts message example, green('PASSED')
    output.flush
  end

  def example_pending (example, message)
    output.puts message example, blue('PENDING')
    output.flush
  end

  def example_group_started (example_group_proxy)
    message = line +
      example_group_proxy.description + ' (' + example_group_proxy.examples.size.to_s + " examples)\n" +
      line

    output.puts(message)
    output.flush
  end

  def message (example, text)
    example.description.ljust(OperaWatir::Helper.terminal_size[0] - 7) + text
  end

  def line
    message = ''
    i = 0

    begin
      message += '-'
      i += 1
    end while i < OperaWatir::Helper.terminal_size[0]

    message += "\n"
    return message
  end
end

