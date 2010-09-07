module OperaWatir
  class QuickWidget

    def initialize(container,how,what)
      @container,@how, @what = container, how, what
    end

    # Locate the element on the page.  Elements can be located using one
    # of the following selectors:
    #
    # * name
    # * id
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def locate
      case @how
      when :name
        @element = @container.driver.findWidgetByName(-1, @what)
      when :id
        @element = @container.driver.findElementById(-1, @what)
      end
    end

    # Checks whether element exists or not.
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def assert_exists
      locate
      unless @element
        raise NoSuchElementException, "Element #{@what} not found using #{@how}"
      end
    end

    def text
      assert_exists
      return @element.getText
    end
  end
end

