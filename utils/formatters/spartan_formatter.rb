# SpartanFormatter is intended for use with Opera's internal testing
# environment SPARTAN.

require 'spec/runner/formatter/base_text_formatter'

class SpartanFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def example_failed(example, counter, failure)
    message = "#{example.description}\tFAILED\n"
    output.puts(message)
    output.flush
  end

  def example_passed(example)
    message = "#{example.description}\tPASSED\n"
    output.puts(message)
    output.flush
  end

  def example_pending(example, message, deprecated_pending_location=nil)
    message = "#{example.description}\tPENDING\n"
    output.puts(message)
    output.flush
  end

  def dump_summary(duration, example_count, failure_count, pending_count); end
  def dump_pending; end
  def dump_failure(counter, failure); end
end
