require "spec/runner/formatter/base_text_formatter"

class SpartanFormatter < Spec::Runner::Formatter::BaseTextFormatter
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
end

