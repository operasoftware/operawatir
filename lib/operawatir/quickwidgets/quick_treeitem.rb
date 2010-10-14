module OperaWatir
  class QuickTreeItem < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:treeitem]
    end

    ######################################################################
    # Set focus to the edit field by clicking on it
    #
    def focus_with_click
      super
    end
        
    ######################################################################
    # Switch to the dialog tab by clicking on it 
    #
    def open_tab_with_click
      click()
      
      # No event yet so just cheat and sleep
      sleep(0.2);
    end
    
    ######################################################################
    # Double clicks the tree item, and waits for the window with 
    # window name win_name to be shown
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def open_window_with_double_click(win_name)
      wait_start
      click(:left, 2)
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_double_click, :open_window_with_double_click

  end
end

