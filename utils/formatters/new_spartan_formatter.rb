# SpartanFormatter is intended for use with Opera's internal testing
# environment SPARTAN.

require 'rspec/core/formatters/base_text_formatter'

class SpartanFormatter < RSpec::Core::Formatters::BaseTextFormatter

  def initialize(output)
    super(output)
    @groups = []
  end

  def example_group_started(example_group)
    @groups.push example_group.description
  end

  def example_group_finished(example_group)
    @groups.pop
  end

  def example_passed(example)
    concat_name(example.description, "PASS")
  end

  def example_failed(example, counter = 0, failure = "")
    concat_name(example.description, "FAIL")
  end

  def example_pending(example, message = "", deprecated_pending_location=nil)
    concat_name(example.description, "FAIL")
  end

  def dump_summary(duration, example_count, failure_count, pending_count); end
  def dump_pending; end
  def dump_failure(counter, failure); end
  # Suppress all other messages
  def message(message) end

  private

  def concat_name(name, status)
    name = (@groups + [name]).join('#')

    message = "#{name}\t#{status}\n"
    output.puts(message)
    output.flush
  end

end
