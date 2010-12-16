module OperaWatir
  module Compat
    module Window

      # Checks whether the body has the given text in it.
      # @param [String] str Text to search for.
      # @return [Boolean] true if the body contains the given text, false otherwise
      def contains_text(str)
        text.index(str)
      end

      # Find elements that match the given XPath.
      # @param [String] value The XPath expression to search for.
      # @return [OperaWatir::Collection] A collection of matching elements.
      def elements_by_xpath(value)
        find_by_xpath(value)
      end

      alias_method :element_by_xpath, :elements_by_xpath

    end
  end
end
