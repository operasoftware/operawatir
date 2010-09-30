module OperaWatir
  class QuickWidget
    include DesktopCommon
#    include DesktopEnums

    def initialize(container, method, selector=nil)
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWidget
        @elm = method
      else
        @method    = method
        @selector  = selector.to_s
      end
    end

    # Checks whether widget exists or not.
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
    
    # Returns the type of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def type
      WIDGET_ENUM_MAP.invert[element.getType]
    end
    
    # Returns the text of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def name
      element.getName
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
    
    #def drag_and_drop_on(other)
    #   element.dragAndDropOn other
    #end

private

    def driver
      @container.driver
    end

    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def focus_with_click
      click()
      
      # No event yet so just cheat and sleep
      sleep(0.1);
    end
    
    # Click widget
    #
    # Params: button (:left, :right, :middle)
    #         times
    #         modifiers ([:shift, :ctrl, ...]
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def click(button = :left, times = 1, *opts)
      #DesktopEnums::KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
      button = DesktopEnums::MOUSEBUTTON_ENUM_MAP[button]
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << DesktopEnums::KEYMODIFIER_ENUM_MAP[mod] }
      element.click(button, times, list)
    end
    
    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def right_click
      click(:right, 1)
    end
    
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
      case @method
      when :name
        @element = driver.findWidgetByName(-1, @selector)
        raise(Exceptions::UnknownObjectException, "Element #{@selector} has wrong type") unless correct_type?
        @element
      end
    end
  end
end
