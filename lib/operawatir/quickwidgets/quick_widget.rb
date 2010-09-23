module OperaWatir
  class QuickWidget
    
    #WIDGET_ENUM_MAP = { :unknown => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::UNKNOWN, 
    #                    :button => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::BUTTON, 
    #                    :checkbox => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::CHECKBOX,
    #                    :dialogtab => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::DIALOGTAB,
    #                    :dropdown => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::DROPDOWN,
    #                    :editfield => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::EDITFIELD,
    #                    :label => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::LABEL,
    #                    :radiobutton => DesktopWmProtos::QuickWidgetInfo::QuickWidgetType::RADIOBUTTON
    #} 
    
    WIDGET_ENUM_MAP = DesktopWmProtos::QuickWidgetInfo::QuickWidgetType.constants.inject({}) do |acc, const|
      #puts const.inspect
      acc[const.to_s.downcase.to_sym] = DesktopWmProtos::QuickWidgetInfo::QuickWidgetType.const_get(const)
      acc
    end
    
    def initialize(container, method, selector)
      @container = container
      @method    = method
      @selector  = selector
    end
    
    
    def click(button = 0, num_times = 1, modifier = 0)
       element.click(button, num_times, modifier)
    end
    #def click(button, times = 1, *opts)
      #puts "Click #{button} #{times} times"
     # opts.each { |opt| puts opt }
     # opts.map {|mod| self.class.const_get(mod.to_s.upcase.to_sym)}.
      #          each {|mod| puts "Modifier #{mod} held down" }
      #element.click(button, times, opts)
    #end

    def right_click
      click()
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
    
  # Returns the type of the widget
      #
      # Raises:
      # NoSuchElementException::   if the element is not found.
      def type
        element.getType
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
        #puts "--- constants ---"
        #puts DesktopWmProtos::QuickWidgetInfo::QuickWidgetType.constants
        #puts "-----"
        #puts WIDGET_ENUM_MAP
        #puts "-----------------"
        @element = @container.driver.findWidgetByName(-1, @selector)
        raise(Exceptions::UnknownObjectException, "Element #{@selector} has wrong type") unless correct_type?
        @element
      end
    end

  end
end

