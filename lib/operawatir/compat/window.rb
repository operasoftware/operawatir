module OperaWatir
  module Compat
    module Window

      def contains_text(str)
        text.index(str)
      end
      
      #alias_method :element_by_xpath, :find_by_xpath
#      alias_method :elements_by_xpath, :find_elements_by_xpath

      def elements_by_xpath(value)
#        OperaWatir::Collection.new(self).tap do |c|
#          c.selector.send(:xpath, value)
#        end._elms

        #self.parent.send('find_element_by_xpath', value)

        #self.find_element_by_xpath(value)
        find_by_xpath(value)

      end

      alias_method :element_by_xpath, :elements_by_xpath

#      def element_by_xpath(value)
#        OperaWatir::Collection.new(self).tap do |c|
#          c.selector.send(:xpath, value)
#        end
#      end
      
    end
  end
end
