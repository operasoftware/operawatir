module OperaWatir
  class QuickWidget
    include DesktopCommon
    include DesktopContainer
    include Deprecated
    
    ConditionTimeout = 10.0
    
    # @private
    # window_id is set if constructor is called on a (parent) window
    # location is set is this is called on a (parent) widget
    def initialize(container, method, selector=nil, location=nil, window_id=-1, type=nil)
      
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickWidget
        @elm = method
        @type = WIDGET_ENUM_MAP.invert[method.getType]
      else
        @method    = method
        @type      = type
        @selector  = selector
        @location  = location
        @window_id  = window_id
      end
    end
    
    #######################################################################
    # 
    # Hovers widget and waits for window to be shown
    #
    #
    def open_window_with_hover(win_name = "")
      wait_start
      element.hover
      wait_for_window_shown(win_name)
    end
    
    ######################################################################
    # Rightclicks the widget, and waits for the menu with name
    # menu_name to be shown
    #
    # @param [String] menu name (from standard_menu.ini)
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def open_menu_with_rightclick(menu_name)
      wait_start
      click(:right)
      wait_for_menu_shown(menu_name)
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
    # Gets the text of the widget
    #
    # @note This method should not be used to check the text in a widget if
    #       the text is in the Opera language file. Use verify_text instead
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
    # Gets the name of the widget (as it appears in dialog.ini or code)
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
    # Gets a string representation of the widget
    #
    # @return [String] representation of the widget
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def to_s
      "#{type.to_s.capitalize} #{name}, text=#{text}, parentName=#{parent_name}, visible=#{visible?}, enabled=#{enabled?}, position=#{row},#{col}"
    end

    ######################################################################
    # Checks that the text in the widget matches the text as loaded
    # from the current language file in Opera using the string_id
    # (Strips &'s from the string before comparing)
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
      text = driver.getString(string_id, true) #true => stripAmpersands from string
      if text.include? "%"
        text.gsub!(/%[csduoxefg0-9]/, ".*")
        res = /#{text}/ =~ element.getText()
        res == nil ? false: true
      else
        element.verifyText(string_id) 
      end
    end
  
    alias_method :has_ui_string?, :verify_text
    
    ######################################################################
    # Checks that the text in the widget matches the text as loaded
    # from the current language file in Opera using the string_id
    # (Strips &'s from the string before comparing)
    #
    # @param [String] string_id String ID to use to load the string from the current
    #                 language file (e.g. "D_NEW_PREFERENCES_GENERAL")
    # 
    # @return [Boolean] true if the text matches, otherwise false
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def verify_text(string_id, *params)
      text = driver.getString(string_id, true)
      verify_realtext(text, *params)
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
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    def verify_includes_text(string_id)
      element.verifyContainsText(string_id)
    end
    
    alias_method :includes_text?, :verify_includes_text
    deprecated :verify_includes_text
    deprecated :includes_text?

    ######################################################################
    # Prints out all of the row/col information in single lines. Used to
    # check items from lists
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #
    #@private
    def print_row
      puts row_info_string
    end

    ######################################################################
    # Prints out all of the row/col information in single lines. Used to
    # check items from lists
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #               using the specified method
    #@private
    def row_info_string
      if element.getColumn() == 0
        "Parent: " + element.getParentName() + ", Item: " + element.getRow().to_s + ", Text: " + text
      end
      ""
    end

    ########################################################################
    #
    # @return position for elements that have a position, else false
    #
    def position
      case type
        when :treeitem then [row, col]
        when :tabbutton, :button then col
        else false
      end
      #return [row, col] if type == :treeitem
      #return col if type == :tabbutton
      #return col if type == :button
      #false
    end

    ########################################################################
    #
    # @return width of widget
    #
    def width
      element.getRect().width
    end

    ########################################################################
    #
    # @return height of widget
    #
    def height
      element.getRect().height
    end

    #@private
    def x
      element.getRect().x
    end

    #@private
    def y
      element.getRect().y
    end
    
    ######################################################################
    # Prints out all of the internal information about the widget. Used
    # to discover the names of widgets and windows to use in the tests
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #           using the specified method 
    #@private
    def print_widget_info
      puts widget_info_string
    end

    ######################################################################
    # Returns a string of all of the internal information about the widget. Used
    # to discover the names of widgets and windows to use in the tests
    #
    # @raise [Exceptions::UnknownObjectException] if the widget cannot be found
    #           using the specified method 
    #
    def widget_info_string
      "   Name: " + name + 
      "\n   Text: " + text +
      "\n   Type: " + type.to_s +
      "\n Parent: " + element.getParentName() +
      "\nVisible: " + visible?.to_s +
      "\nEnabled: " + enabled?.to_s +
      "\n    Pos: x=" + element.getRect().x.to_s + ", y=" + element.getRect().y.to_s +
      "\n   Size: width=" + element.getRect().width.to_s + ", height=" + element.getRect().height.to_s +
      "\n    Ref: row=" + element.getRow().to_s + ", col=" + element.getColumn().to_s +
      "\nselected: " + element.isSelected().to_s + "\n"
    end
          
    # @private
    def driver
      @container.driver
    end
    
    # Gets parent widget name
    def parent_name
      element.getParentName()
    end
    
    #################################################################
    # Focus a widget with a click
    #
    def focus_with_click
      click
      # No event yet so just cheat and sleep
      sleep(0.1);
    end
    
    ###############################################################
    #
    # double_click_with_condition { block } → res
    #
    # Doubleclicks widget and waits until block evaluates to true or timeout is hit 
    #
    # @return value of block, or false if no block provided
    #
    def double_click_with_condition(&condition)
      click_with_condition_internal(:left, 2, &condition)
    end
    
    ###############################################################
    #
    # right_click_with_condition { block } → res
    #
    # Rightclicks widget and waits until block evaluates to true or timeout is hit 
    #
    # @return value of block, or false if no block provided
    #
    def right_click_with_condition(&condition)
      click_with_condition_internal(:right, 1, &condition)
    end
    
    ###############################################################
    #
    # click_with_condition { block } → res
    #
    # @example 
    #      browser.quick_button(:name, "[buttonname]").click_with_condition { 
    #            browser.quick_treeview(:name, "[name]").quick_treeitems.length == 4 }.should be_true
    #
    # Clicks widget and waits until block evaluates to true or timeout is hit 
    #
    # @return value of block, or false if no block provided
    #
    def click_with_condition(&condition)
      click_with_condition_internal(:left, 1, &condition)
    end
    

    #######################################################
    #
    #
    #
    def value
      return element.getValue
    end
    
    #########################################################
    #
    # @return all widgets inside this widget
    #
    # @example
    #    browser.quick_treeview(:name, "Mail View").quick_widgets
    # 
    # @note 
    #   you can also specify the widgets by type to retrieve only
    #   a specific type of widgets
    # 
    # @example
    #      browser.quick_treeview(:name, "Mail View").quick_treeitems
    #
    #
    def quick_widgets
      widgets(window_id)
    end
    
    WIDGET_ENUM_MAP.keys.each do |widget_type|
      my_type = "quick_" << widget_type.to_s
      type = my_type
      if my_type == "quick_search" || my_type == "quick_checkbox"
        my_type << "es"
      else
        my_type << "s"
      end
      define_method(my_type.to_sym) do #|win|
        quick_widgets.select { |w| w.type == widget_type and w.parent_name == name }
      end
    end
    
protected
    #@private
    # Return the element
    def element(refresh = false)
      if (@elm == nil || refresh == true)
        @elm = find
      end
      
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @elm 
      @elm
    end

  
private
  def click_with_condition_internal(button = :left, times = 1, &blk)
      return false unless block_given?

      click(button, times)
  
      start = Time.now
      until res = yield rescue false do
        if Time.now - start > ConditionTimeout
          return false
        end
        sleep 0.1
      end
        res
    end

# Right click a widget
  def right_click
    click(:right, 1)
  end

  # Click widget
  def click(button = :left, times = 1, *opts)

    #raise DesktopExceptions::WidgetDisabledException, "Element #{@selector} is disabled" unless enabled?

    #Some buttons etc. aren't visible until hovering them
    if (visible? == false and type != :dialogtab)
      element.hover
      element(true)
    end

    # Dialog tabs are always visible even if the page they are connected to isn't
    if visible? == true or type == :dialogtab
      button = DesktopEnums::MOUSEBUTTON_ENUM_MAP[button]
      list = Java::JavaUtil::ArrayList.new
      opts.each { |mod| list << DesktopEnums::KEYMODIFIER_ENUM_MAP[mod] }
      element.click(button, times, list)
    else
      raise(DesktopExceptions::WidgetNotVisibleException, "Widget #{name.length > 0 ? name : text} not visible")
    end
  end

  def verify_realtext(text, *params)
    if text.include? "%1"
      result = text.scan(/%\d/)
      if (params.length == result.length)
        result.length.times do |time|
          number = time+1
          p = params[time]
          text.gsub!("%#{number}", params[time])
        end
      end
      text == element.getText()
    else
      params.each do |param|
        text.gsub!(/%[csduoxefg0-9]/, param)
      end
     text == element.getText()
    end
  end

    
   def drag_and_drop_on(other, drop_pos)
     element.dragAndDropOn(other.element, DROPPOSITION_ENUM_MAP[drop_pos])
   end

    # Gets the widget name (used as parent name when creating child widget)
    def parent_widget
      if @selector == nil && @elm != nil
         set_selector
      end
      
      #FIXME: Shouldn't this always be name if present, then text if present, else pos?
      case @method
      when :name
        name
      when :text
        #text
        name.length > 0 ? name : text
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
    
   
    # double click widget
    def double_click
      click(:left, 2) 
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
=begin          
      # tabbuttons now specified by generated name
      elsif @elm.type == :tabbutton
        @method = :pos
        @selector = @elm.col
=end        
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
      #puts "\n<find> Find Widget by " + @method.to_s + " " + @window_id.to_s + ", " + @selector.to_s + ", " + @location.to_s + ", " + @type.to_s
      case @method
      when :name
        if @location != nil
          @element = driver.findWidgetByName(WIDGET_ENUM_MAP[@type], @window_id, @selector, @location)
        else
          @element = driver.findWidgetByName(WIDGET_ENUM_MAP[@type], @window_id, @selector)
        end
      when :string_id
        if @location != nil
          @element = driver.findWidgetByStringId(WIDGET_ENUM_MAP[@type], @window_id, @selector, @location)
        else
          @element = driver.findWidgetByStringId(WIDGET_ENUM_MAP[@type], @window_id, @selector)
        end
      when :text
        if @location != nil
          @element = driver.findWidgetByText(WIDGET_ENUM_MAP[@type], @window_id, @selector, @location)
        else
          @element = driver.findWidgetByText(WIDGET_ENUM_MAP[@type], @window_id, @selector)
        end
      when :pos
        if @location != nil
          @element = driver.findWidgetByPosition(WIDGET_ENUM_MAP[@type], @window_id, @selector[0], @selector[1], @location)
        else
          @element = driver.findWidgetByPosition(WIDGET_ENUM_MAP[@type], @window_id, @selector[0], @selector[1])
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
