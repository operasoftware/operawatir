module OperaWatir
  class QuickButton < QuickWidget
 
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:button]
    end

    ######################################################################
    # Checks if the button is the default button
    #
    # @return [Boolean] true if the default button otherwise false
    #
    def default?
      element.isDefault
    end

    ######################################################################
    # Clicks the button, and waits for the window with window name 
    # win_name to be shown
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def open_window_with_click(win_name)
      wait_start
      click
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_click, :open_window_with_click

    ######################################################################
    # Clicks the button, and waits for the dialog wizard to switch
    # to the next page
    #
    # @return [int] Window ID of the dialog wizard or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def change_page_with_click()
      wait_start
      click
      wait_for_window_shown("")
    end
    
    ######################################################################
    # Clicks the button, and waits for the window with window name 
    # win_name to closed
    #
    # @param [String] win_name name of the window that will be closed (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window is closed or 0 if no window is closed
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def close_window_with_click(win_name)
      wait_start
      click
      wait_for_window_close(win_name)
    end
    
    alias_method :close_dialog_with_click, :close_window_with_click
    
    ######################################################################
    # Clicks the button, and waits for loading to finish
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def load_page_with_click
      wait_start
      click()
      # Just wait for the load
      wait_for_window_loaded("")
    end
        
    
    ######################################################################
    # Clicks a button or expand control and toggles it state
    #
    # @return [int] the new state of the button or expand control,
    #               0 for not pressed, or 1 for pressed
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def toggle_with_click
      click
          
      # Cheat since we don't have an event yet 
      sleep(0.1)
        
      element(true).getValue
    end
  
    ######################################################################
    # Clicks button to close the toolbar 
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the button
    #            is not visible
    #
    def close_toolbar_with_click
      click
      
      # Cheat since we don't have an event yet
      sleep(0.1)
    end
          
    alias_method :close_panel_with_click, :close_toolbar_with_click
    
    def expand_with_click
      click
      sleep(0.1)
      #No refresh element because it might not be there still (after click):)
    end
    
    alias_method :collapse_with_click, :expand_with_click
    
    ######################################################################
    # Gets the value of the button or expand control.
    #
    # @return [int] 0 if not pressed, or 1 if pressed
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def value
      element.getValue
    end
    
    ######################################################################
    # Pauses to wait for security dialogs when buttons are not active
    # right away on opening 
    #
    # @return [Boolean] Returns true if the button becomes active
    #
    def wait_for_enabled
      wait_for_widget_enabled
    end
    
  end
end
