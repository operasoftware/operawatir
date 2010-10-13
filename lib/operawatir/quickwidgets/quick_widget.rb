module OperaWatir
  class QuickWidget
    include DesktopCommon
    include DesktopContainer
    
    # @private
    # window_id is set if constructor is called on a (parent) window
    # location is set is this is called on a (parent) widget
    def initialize(container, method, selector=nil, location=nil, window_id=-1)
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWidget
        @elm = method
      else
        @method    = method
        @selector  = selector.to_s
        @location  = location
        @window_id  = window_id
        #puts "Constructed widget #{@selector} inside #{@location} in window with id #{@window_id}"
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
    # Get a string representation of the widget
    #
    # @return [String] representation of the widget
    #
    def to_s
      "#{type.to_s.capitalize} #{name}, visible=#{visible?}, enabled=#{enabled?}, text=#{text}, parentName=#{parent_name}"
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
  
    alias_method :is_text?, :verify_text
    
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
    
    alias_method :includes_text?, :verify_includes_text

    ######################################################################
    # Prints out all of the internal information about the widget. Used
    # to discover the names of widgets and windows to use in the tests
    #
    def print_widget_info
      puts "   Name: " + name
      puts "   Text: " + text
      puts "   Type: " + type.to_s
      puts " Parent: " + element.getParentName()
      puts "Visible: " + visible?.to_s
      puts "Enabled: " + enabled?.to_s
      puts "    Pos: x=" + element.getRect().x.to_s + ", y=" + element.getRect().y.to_s
      puts "   Size: width=" + element.getRect().width.to_s + ", height=" + element.getRect().height.to_s
      puts "    Ref: row=" + element.getRow().to_s + ", col=" + element.getColumn().to_s
      puts ""
    end
          
    # @private
    def driver
      @container.driver
    end

private
    # Gets the widget name (used as parent name when creating child widget)
    def parent_widget
      case @method
      when :name
        element.getName()
      when :text
        element.getText()
      when :pos
        raise(Error, "SearchType position not supported yes") 
      end
    end
    
    #Get parent widget name
    def parent_name
      element.getParentName()
    end

    # Gets the window id to use for the search
    def window_id
      # Need to pass on the current setting of @window_id to make
      # nesting of quick widgets work
      @window_id
    end
    
    # Click widget
    def click(button = :left, times = 1, *opts)
       #DesktopEnums::KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
       button = DesktopEnums::MOUSEBUTTON_ENUM_MAP[button]
       list = Java::JavaUtil::ArrayList.new
       opts.each { |mod| list << DesktopEnums::KEYMODIFIER_ENUM_MAP[mod] }
       element.click(button, times, list)
     end
    
    # Focus a widget with a click
    def focus_with_click
      click
      # No event yet so just cheat and sleep
      sleep(0.1);
    end
    
    
    # Right click a widget
    def right_click
      click(:right, 1)
    end
    
    # double click widget
    def double_click
      click(:left, 2) 
    end

    # Return the element
    def element(refresh = false)
      if (@elm == nil || refresh == true)
        @elm = find
      end
      
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @elm 
      @elm
    end
    
    # Finds the element on the page.  
    def find
      case @method
      when :name
        #puts "<find> Find Widget by name: " + @window_id.to_s + ", " + @selector.to_s + ", " + @location.to_s
        if @location != nil
          @element = driver.findWidgetByName(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByName(@window_id, @selector)
        end
      when :string_id
        if @location != nil
          @lement = driver.findWidgetByStringId(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByStringId(@window_id, @selector)
        end
      when :text
        if @location != nil
          @element = driver.findWidgetByText(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByText(@window_id, @selector)
        end
     end
      if @window_id < 0 && @element != nil
         @window_id = @element.getParentWindowId
      end
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @element 
      raise(Exceptions::UnknownObjectException, "Element #{@selector} has wrong type #{@element.getType}") unless correct_type?
      @element
    end
  end
end
