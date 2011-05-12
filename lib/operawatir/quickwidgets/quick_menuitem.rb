module OperaWatir
  class QuickMenuItem < QuickWidget #

    # @private
    # Checks the type of the widget is correct
    #def correct_type?
    #  @element.getType == WIDGET_ENUM_MAP[:menuitem]
    #end
    
    # @private
    # window_id is set if constructor is called on a (parent) window
    # location is set is this is called on a (parent) widget
    def initialize(container, method, selector=nil, location=nil)
      
      #puts "QuickMenuItem initialize method #{method}, selector #{selector}"
      
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickMenuItem
        @elm = method
      else
        @method    = method
        @selector  = selector
        @location  = location
      end
    end
    
     def name
       element.getName
     end
     
     def text
       element.getText()
     end
     
     def string_id
       element.getStringId()
     end
     
     def selected?
       element.isSelected()
     end
     
     def bold?
       element.isBold()
     end
     
     def has_submenu?
       element.hasSubmenu()
     end
     
     def shortcutletter
       element.getShortcutLetter()
     end
     
     def shortcut
       element.getShortcut()
     end
     
     def row
       element.getRow()
     end
     
     def action
       element.getActionName()
     end
     
     def submenu
       element.getSubMenu()
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
   
    #
    # TODO: Document
    #
    def open_menu_with_hover(menu_name)
      wait_start
      element.hover
      wait_for_menu_shown(menu_name)
    end
    
    ######################################################################
    # Clicks the button, and waits for the window with menu with name
    # menu_name to be shown
    #
    # @param [String] 
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def open_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_shown(menu_name)
    end


    # Obs: Dont repeat these here, only temporary    
    def load_page_with_click
      wait_start
      click
      # Just wait for the load
      wait_for_window_loaded("")
    end
    
    def click
      super
    end
    
    def open_window_with_click(win_name)
      wait_start
      click
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_click, :open_window_with_click
    
    def close_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_closed(menu_name)
    end
    
    def to_s
      "QUICKMENUITEM #{name}"
    end


private    
    # Finds the element on the page.  
    def find
      #If @method set and we do new find because of refresh, we need to get @selector first
      #Have the java object because the construct was done on it
      #if @selector == nil && @elm != nil
      #  set_selector
      #end
      #puts "\n<find> Find Menu by " + @method.to_s + ", " + @selector.to_s + ", " + @location.to_s
      case @method
        # action or submenu name?
      when :name
        @element = driver.getQuickMenuItemByName(@selector)
      when :action
        @element = driver.getQuickMenuItemByAction(@selector)
      when :submenu
        @element = driver.getQuickMenuItemBySubmenu(@selector)
      #when :string_id
      #  @element = driver.getMenuItemByStringId(WIDGET_ENUM_MAP[@type], @window_id, @selector, @location)
      when :text
        @element = driver.getQuickMenuItemByText(@selector)
      when :pos # only row
        @element = driver.getQuickMenuItemByPosition(@selector, @location)
      when :acckey
        @element = driver.getQuickMenuItemByAccKey(@selector, @location)
      when :shortcut
        @element = driver.getQuickMenuItemByShortcut(@selector)
      when :string_id
        @element = driver.getQuickMenuItemByStringId(@selector)
      end
        
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @element 
      @element
    end


  end
end
