require '../operawatir'

# I'll play along with this black magic for the moment...

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
OperaWatir::Helper.run!
