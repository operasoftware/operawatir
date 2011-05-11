module OperaWatir
  class QuickMenuItem < QuickWidget

    # @private
    # Checks the type of the widget is correct
    #def correct_type?
    #  @element.getType == WIDGET_ENUM_MAP[:menuitem]
    #end
    
    # @private
    # window_id is set if constructor is called on a (parent) window
    # location is set is this is called on a (parent) widget
    def initialize(container, method, selector=nil, location=nil)
      
      puts "QuickMenuItem initialize method #{method}, selector #{selector}"
      
      @container = container
                            
      if method.is_a? Java::ComOperaCoreSystems::QuickMenuItem
        @elm = method
      else
        @method    = method
        @selector  = selector
        @location  = location
      end
    end
    
    #
    # TODO: Document
    #
    def open_menu_with_hover(menu_name)
      wait_start
      element.hover
      wait_for_menu_shown(menu_name)
    end
    
    def click
      puts "quick_menuitem#click "
      super
    end
    
    def close_menu_with_click(menu_name)
      wait_start
      click
      wait_for_menu_closed(menu_name)
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
      end
        
        
      raise(Exceptions::UnknownObjectException, "Element #{@selector} not found using #{@method}") unless @element 
      @element
    end


  end
end
