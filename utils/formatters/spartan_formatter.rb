# SpartanFormatter is intended for use with Opera's internal testing
# environment SPARTAN.

require 'rspec/core/formatters/base_text_formatter'

class SpartanFormatter < RSpec::Core::Formatters::BaseTextFormatter
  def example_failed(example)
    message = "#{example.description}\tFAILED\n"
    output.print message
  end

  def example_passed(example)
    message = "#{example.description}\tPASSED\n"
    output.print message
  end

  def example_pending(example)
    message = "#{example.description}\tPENDING\n"
    output.print message
  end

  def start_dump
    output.puts
  end

#  def dump_summary(duration, example_count, failure_count, pending_count); end
#  def dump_pending; end
#  def dump_failure(counter, failure); end
end
