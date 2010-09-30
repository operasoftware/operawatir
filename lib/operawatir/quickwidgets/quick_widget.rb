module OperaWatir
  class QuickWidget
    include DesktopCommon

    # @private
    def initialize(container, method, selector=nil)
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWidget
        @elm = method
      else
        @method    = method
        @selector  = selector.to_s
      end
    end

    ######################################################################
    # Checks whether a widget exists or not
    #
    # @return [Boolean] true if the widget exists otherwise false
    #
    def exist?
      !!element
      rescue Exceptions::UnknownObjectException
        false
    end
    alias_method :exists?, :exist?
    
    ######################################################################
    # Checks if a widget is enabled or not
    #
    # @return [Boolean] true if enabled otherwise false
    #
    def enabled?
      element.isEnabled
    end
      
    ######################################################################
    # Checks if a widget is visible or not
    #
    # @return [Boolean] true if visible otherwise false
    #
    def visible?
      element.isVisible
    end

    ######################################################################
    # Get the text of the widget
    #
    # @note This method should not be used to check the text in a widget if
    #       the text is in the Opera language file. Use verify_text or
    #       verify_includes_text instead
    #
    # @return [String] text of the widget
    #
    def text
      element.getText
    end
    
    ######################################################################
    # Gets the type of a widget
    #
    # @return [Symbol] type of the widget (e.g. :dropdown, :button)
    #
    def type
      WIDGET_ENUM_MAP.invert[element.getType]
    end
    
    ######################################################################
    # Get the name of the widget (as it appears in dialog.ini or code)
    #
    # @return [String] name of the widget
    #
    def name
      element.getName
    end

    ######################################################################
    # Checks that the text in the widget matches the text as loaded
    # from the current language file in Opera using the string_id
    #
    # @param [String] string_id String ID to use to load the string from the current
    #                 language file (e.g. "D_NEW_PREFERENCES_GENERAL")
    # 
    # @return [Boolean] true if the text matches, otherwise false
    #
    def verify_text(string_id)
      element.verifyText(string_id);
    end
    
    ######################################################################
    # Checks that the text in the widget includes the text as loaded
    # from the current language file in Opera using the string_id
    #
    # @param [String] string_id String ID to use to load the string from the current
    #                 language file (e.g. "D_NEW_PREFERENCES_GENERAL")
    # 
    # @return [Boolean] true if the text is included, otherwise false
    #
    def verify_includes_text(string_id)
      element.verifyContainsText(string_id)
    end
    
private

    def driver
      @container.driver
    end

    # Focus a widget with a click
    def focus_with_click
      click()
      
      # No event yet so just cheat and sleep
      sleep(0.1);
    end
    
    # Click widget
    def click(button = :left, times = 1, *opts)
      #DesktopEnums::KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
      button = DesktopEnums::MOUSEBUTTON_ENUM_MAP[button]
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << DesktopEnums::KEYMODIFIER_ENUM_MAP[mod] }
      element.click(button, times, list)
    end
    
    # Right click a widget
    def right_click
      click(:right, 1)
    end
    
    # Return the element
    def element
      @elm ||= find || raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}")
    end

    # Finds the element on the page.  
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
