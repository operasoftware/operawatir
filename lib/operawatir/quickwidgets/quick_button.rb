module OperaWatir
  class QuickButton < QuickWidget
 
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:button];
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
    def open_window_with_click(win_name)
      wait_start
      click()
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_click, :open_window_with_click
    
    ######################################################################
    # Clicks the button, and waits for the window with window name 
    # win_name to closed
    #
    # @param [String] win_name name of the window that will be closed (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window is closed or 0 if no window is closed
    #
    def close_window_with_click(win_name)
      wait_start
      click()
      wait_for_window_close(win_name)
    end

    alias_method :close_dialog_with_click, :close_window_with_click
    
  end
end
