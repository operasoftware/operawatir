module OperaWatir
  module Compat
    module Window

      def contains_text(str)
        text.index(str)
      end
      
      #alias_method :element_by_xpath, :find_by_xpath

      def elements_by_xpath(value)
        find_by_xpath(value)
      end

      alias_method :element_by_xpath, :elements_by_xpath

    end
  end
end
