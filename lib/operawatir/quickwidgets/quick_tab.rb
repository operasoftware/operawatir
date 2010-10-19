module OperaWatir
  class QuickTab < QuickButton
 
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:tabbutton]
    end

    
    ######################################################################
    # Clicks the tab button, and waits for the tab to be shown / switches to the page
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown 
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the tab button
    #            is not visible
    #
    def open_tab_with_click
      wait_start
      click 
      wait_for_window_activated("Document Window")
    end
    
    alias_method :open_page_with_click, :open_tab_with_click    
    
  end
end