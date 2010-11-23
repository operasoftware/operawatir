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
        @selector  = selector
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
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method  
    #
    def enabled?
      element.isEnabled
    end
      
    ######################################################################
    # Checks if a widget is visible or not
    #
    # @return [Boolean] true if visible otherwise false
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #           using the specified method  
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
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #           using the specified method  
    #
    def text
      element.getText
    end
    
    ######################################################################
    # Gets the type of a widget
    #
    # @return [Symbol] type of the widget (e.g. :dropdown, :button)
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found 
    #               using the specified method
    #    
    def type
      WIDGET_ENUM_MAP.invert[element.getType]
    end
    
    ######################################################################
    # Get the name of the widget (as it appears in dialog.ini or code)
    #
    # @return [String] name of the widget
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def name
      element.getName
    end
    
    ######################################################################
    # Get a string representation of the widget
    #
    # @return [String] representation of the widget
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def to_s
      "#{type.to_s.capitalize} #{name}, visible=#{visible?}, enabled=#{enabled?}, text=#{text}, parentName=#{parent_name}, position=#{row},#{col}"
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
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
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
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def verify_includes_text(string_id)
      element.verifyContainsText(string_id)
    end
    
    alias_method :includes_text?, :verify_includes_text

    ######################################################################
    # Prints out all of the row/col information in single lines. Used to
    # check items from lists
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def print_row
      if element.getColumn() == 0
        puts "Parent: " + element.getParentName() + ", Item: " + element.getRow().to_s + ", Text: " + text
      end
    end

    # @return position for elements that have a position, else false
    def position
      return [row, col] if type == :treeitem
      return col if type == :tabbutton
      false
    end
    
    def drag_and_drop_on(other)
      element.dragAndDropOn other
    end

   
    ######################################################################
    # Prints out all of the internal information about the widget. Used
    # to discover the names of widgets and windows to use in the tests
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #           using the specified method 
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
      puts "selected: " + element.isSelected().to_s
      puts ""
    end
          
    # @private
    def driver
      @container.driver
    end
    
    # parent is container
    # Get parent widget name
    def parent_name
      element.getParentName()
    end
    
    # Focus a widget with a click
    def focus_with_click
      click
      # No event yet so just cheat and sleep
      sleep(0.1);
    end

private
    
    # Gets the widget name (used as parent name when creating child widget)
    def parent_widget
      if @selector == nil && @elm != nil
         set_selector
      end
      case @method
      when :name
        name
      when :text
        text
      when :pos
        # Pos items will have the name as the parent or
        # the text if there is no name
        name.length > 0 ? name : text
      end
    end

    # Get row    
    def row
      element.getRow()
    end

    # Get column
    def col
      element.getColumn()
    end
    
    # Gets the window id to use for the search
    def window_id
      # Need to pass on the current setting of @window_id to make
      # nesting of quick widgets work
      @window_id
    end
    
    # Click widget
    def click(button = :left, times = 1, *opts)
      raise Exceptions::WidgetDisabledException, "Element #{@selector} is disabled" unless enabled?
      # Dialog tabs are always visible even if the page they are connected to isn't
      if visible? == true or type == :dialogtab
        #DesktopEnums::KEYMODIFIER_ENUM_MAP.each { |k, v| puts "#{k},#{v}"}
        button = DesktopEnums::MOUSEBUTTON_ENUM_MAP[button]
        list = Java::JavaUtil::ArrayList.new
        opts.each { |mod| list << DesktopEnums::KEYMODIFIER_ENUM_MAP[mod] }
        element.click(button, times, list)
      else
        raise(DesktopExceptions::WidgetNotVisibleException, "Widget #{name.length > 0 ? name : text} not visible")
      end
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
    
    def set_selector
      if @elm.name.length > 0
        @method = :name
        @selector = @elm.name
      elsif @elm.text.length > 0
        @method = :text
        @selector = @elm.text
      elsif @elm.type == :treeitem
        @method = :pos
        @selector = [@elm.row, @elm.col]
      elsif @elm.type == :tabbutton
        @method = :pos
        @selector = @elm.col
      end
      @location = element.getParentName()
      @window_id = -1
    end
    
    # Finds the element on the page.  
    def find
      #If @method set and we do new find because of refresh, we need to get @selector first
      #Have the java object because the construct was done on it
      if @selector == nil && @elm != nil
        set_selector
      end
      #puts "<find> Find Widget by " + @method.to_s + " " + @window_id.to_s + ", " + @selector.to_s + ", " + @location.to_s
      case @method
      when :name
        if @location != nil
          @element = driver.findWidgetByName(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByName(@window_id, @selector)
        end
      when :string_id
        if @location != nil
          @element = driver.findWidgetByStringId(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByStringId(@window_id, @selector)
        end
      when :text
        if @location != nil
          @element = driver.findWidgetByText(@window_id, @selector, @location)
        else
          @element = driver.findWidgetByText(@window_id, @selector)
        end
      when :pos
        if @location != nil
          @element = driver.findWidgetByPosition(@window_id, @selector[0], @selector[1], @location)
        else
          @element = driver.findWidgetByPosition(@window_id, @selector[0], @selector[1])
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
