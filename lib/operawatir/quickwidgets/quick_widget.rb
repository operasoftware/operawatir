module OperaWatir
  class QuickWidget

    def initialize(container, method, selector)
      @container = container
      @method    = method
      @selector  = selector
    end
    
    def click(button = MouseButton::LEFT, num_times = 1, modifier = Modifier::NONE)
      element.click(button, num_times, modifier)
    end

    def right_click(button = MouseButton::RIGHT, num_times = 1, modifier = Modifier::NONE)
      element.click(button, num_times, modifier)
    end
    
    def correct_type?
      false
    end

    # Checks whether element exists or not.
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def exist?
      !!element
      rescue Exceptions::UnknownObjectException
        false
    end
    alias_method :exists?, :exist?
    
    # Returns true if the element is enabled, false if it isn't.  First
    # checks if element exists or not.  Then checks if element is enabled
    # or not.
    #
    # Output: 
    #   Returns true if element exists and is enabled, else returns
    #   false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def enabled?
      element.isEnabled
    end
      
    # Returns true if the element is visible, false if it isn't.  First
    # checks if element exists or not.  Then checks if element is enabled
    # or not.
    #
    # Output: 
    #   Returns true if element exists and is visible, else returns
    #   false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def visible?
      element.isVisible
    end

    # Return the text of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def text
      element.getText
    end
    
    # Returns the text of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def name
      element.getName
    end

    # Returns the type of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def type
      element.getType
    end
    
    # Checks if the element text is the one given as parameter.
    #
    # Arguments:
    # string_id:: String ID to use to load the string from the current
    #             language file in Opera and verify against 
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def verify_text(string_id)
      element.verifyText(string_id);
    end
    
    # Checks if the element text includes the one given as parameter.
    #
    # Arguments:
    # string_id:: String ID to use to load the string from the current
    #             language file in Opera and verify against 
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def verify_includes_text(string_id)
      element.verifyContainsText(string_id)
    end

private
    
    # Return the element
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def element
      @elm ||= find || raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}")
    end

    # Finds the element on the page.  Elements can be located using one
    # of the following selectors:
    #
    # * name
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def find
      raise TypeError unless @selector.is_a?(String)

      case @method
      when :name
        @element = @container.driver.findWidgetByName(-1, @selector)
        raise(Exceptions::UnknownObjectException, "Element #{@selector} has wrong type") unless correct_type?
        @element
      end
    end

  end
end

