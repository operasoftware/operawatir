module OperaWatir
  module Compat
    module Browser

      def contains_text(text)
        text.index(text)
      end
      
      alias_method :element_by_xpath, :find_by_xpath
      
      
    end
  end
end
