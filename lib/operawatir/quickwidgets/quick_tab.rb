module OperaWatir
  class QuickTab < QuickButton
 
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:tabbutton]
    end
    
    ######################################################################
    # Drag and drop this tab on tab tab_target
    #
    # @param [QuickTab] tab button to drop this tab on
    #
    #
    # @raise [DesktopExceptions::UnknownObjectException] if the target is not a tab
    #
    def move_with_drag(tab_target)
      raise(Exceptions::UnknownObjectException) unless tab_target.type == :tabbutton
      drag_and_drop_on(tab_target, :middle)
      
      sleep(0.1)
    end
    
    ######################################################################
    # Drag and drop this tab on another tab to add it to its tab group
    #
    # @param [QuickTab] tab (group) button to drop this tab on
    #
    # @raise [DesktopExceptions::UnknownObjectException] if the target is not a tab
    #
    def group_with_drag(tab_target)
      raise(Exceptions::UnknownObjectException) unless tab_target.type == :tabbutton
      
      #Figure out whether to drop left or right
      left_of?(tab_target) ? drag_and_drop_on(tab_target, :left) : drag_and_drop_on(tab_target, :right)
      
      sleep(0.1)
    end
    
        
    ######################################################################
    # Clicks the tab button, and waits for the tab to be shown / switches to the page
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window activated, 
    #               0 if the window is already the active one,
    #               or if no window is active 
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the tab button
    #            is not visible
    #
    def activate_tab_with_click
      wait_start
      click 
      wait_for_window_activated("Document Window")
    end

 private
  
    #FIXME: ?? In the Java ??       
    def left_of?(other)
      element.getRect().x <= other.element.getRect().x
    end
    
  end
end