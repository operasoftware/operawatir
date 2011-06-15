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
    
    #########################################################################
    #
    # Returns the name of the menuitem. The name is either the action name
    # of the action the item performs, or the name of the submenu the item
    # opens. If the item is a separator, the name is "Separator"
    # 
    # @return name of menuitem
    #
    def name
      element.getName();
    end
    
    ##########################################################################
    #
    # @return name of the menu this menuitem is part of 
    #
    def menu
      element.getMenu()
    end
     
    ##########################################################################
    #
    # @return the text of this menu item
    #
    # (Note: this should normally not be used to access the item, as it will
    #        be language dependent)
    #
    def text
      element.getText()
    end
     
    ############################################################################
    #
    # @return the string_id of this menuitem as a string
    #
    def string_id
      element.getStringId()
    end
    
    ###############################################################################
    #
    # @return true if this menuitem is selected, otherwise false
    #
    def selected?
      element.isSelected()
    end
     
    #####################################################################
    #
    # @return true if this menuitem has bold text, otherwise false
    #
    def bold?
      element.isBold()
    end
    
    #####################################################################
    #
    # @return true if this menuitem is a separator, else false
    #
    def separator?
      element.isSeparator()
    end
    
    #####################################################################
    #
    # @return true if this item is a command/action item
    #
    def action_item?
      action.length > 0
    end
    
    ####################################################################
    #
    # @return true if this item opens a submenu
    #
    def submenu_item?
      has_submenu?
    end
     
    #####################################################################
    #
    # @return true if this menuitem opens a submenu, otherwise false
    #
    def has_submenu?
      element.hasSubMenu()
    end
   
    #####################################################################
    #
    # @return shortcutletter of this menuitem (typing this letter while the
    #           menu is open, will select the item)
    #
    def shortcutletter
      element.getShortcutLetter()
    end
     
    #####################################################################
    #
    # @return the shortcut of this menuitem as a string
    #
    def shortcut
      element.getShortcut()
    end
     
    #####################################################################
    #
    # @return position of this menuitem within the menu, also counting 
    #           separators (TODO: Check this!)
    #
    #
    def pos
      element.getRow()
    end
     
    #####################################################################
    #
    # @return the name of the action this item executes when selected 
    #
    def action
      element.getActionName()
    end
    
    ########################################################################
    #
    # @return the parameters to the action that will be used for the action
    #         executed for this item when it is selected
    #
    def action_params
      element.getActionParameter()
    end
    
    ##########################################################################
    #
    # @return the name of the submenu this item opens
    #
    # (Note: an item will either have a submenu, or an action)  
    #
    def submenu
      element.getSubMenu()
    end
       
     
    ########################################################################
    #
    # @return width of the menuitem
    #
    def width
      element.getRect().width
    end
 
    ########################################################################
    #
    # @return height of the menuitem
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
   
    ########################################################################
    # Hovers the menuitem and waits for the menu with menu_name to open
    #
    # @param [String] name of menu that will open
    #
    # @return name of menu opened
    #
    def open_menu_with_hover(menu_name)
      wait_start
      element.hover
      wait_for_menu_shown(menu_name)
    end
    
    ######################################################################
    # Clicks the menuitem, and waits for the menu with menu with name
    # menu_name to be shown
    #
    # @param [String] name of menu that should open
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    # @return name of menu opened
    #
    def open_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_shown(menu_name)
    end


    # Obs: Dont repeat these here, only temporary    _TODO!!
    def load_page_with_click
      wait_start
      click
      # Just wait for the load
      wait_for_window_loaded("")
    end
    
    #def click(button = :left, times = 1, *opts)
    #  super
    #end
    
    ###########################################################
    #
    #
    #
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
      "QUICKMENUITEM #{name}, pos #{pos}, menu #{menu}, rect #{x}, #{y}, #{width}, #{height}, pos #{pos}, acckey #{shortcutletter}, #{shortcut unless shortcut.nil?}"
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
