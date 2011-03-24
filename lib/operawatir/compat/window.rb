module OperaWatir
  module Compat
    module Window
      include Deprecated

      #
      # Checks whether the body has the given text in it.
      #
      # @param [String] str Text to search for.
      # @return [Boolean] true if the body contains the given text,
      #   false otherwise
      #

      def contains_text(str)
        text.index(str)
      end


      #
      # Find elements that match the given XPath.
      #
      # @param [String] value The XPath expression to search for.
      # @return [OperaWatir::Collection] A collection of matching
      #   elements.
      #

      def elements_by_xpath(value)
        find_by_xpath(value)
      end

      alias_method :element_by_xpath, :elements_by_xpath


      #
      # Opera specific
      #

      def get_hash
        visual_hash
      end

      deprecated :get_hash, 'browser.visual_hash'


      #
      # TODO This is a relic from the old OperaWatir implementation,
      # tests should be updated.
      #

      def frame(selector, argument)
        case selector
        when :name
          driver.switch_to.frame(argument)
        when :index
          driver.switch_to.frame(argument.to_i - 1)  # index starts from 1 in Watir
        else
          raise OperaWatir::Exceptions::NotImplementedException,
            "We do not support the `#{selector}' selector yet"
        end
      end


      def switch_to_default
        driver.switch_to.default_content
      end

      
      def show_frames
        frames = driver.list_frames
        puts "There are #{frames.length.to_s} frames"
        frames.each_with_index { |frame, i| puts "frame index: #{(i.to_i + 1).to_s} name: #{frame.to_s}" }
      end

    end
  end
end
