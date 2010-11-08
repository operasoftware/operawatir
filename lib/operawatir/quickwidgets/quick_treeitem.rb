module OperaWatir
  class QuickTreeItem < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:treeitem]
    end

    ######################################################################
    # Set focus to the tree item by clicking on it
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the treeview
    #            the treeitem is in is not visible
    #
    def focus_with_click
      # First scroll the item into view
      scroll_item_into_view unless visible?
      super
    end
        
    ######################################################################
    # Expands a tree item when it is clicked
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the treeitem 
    #            is not visible
    #
    def expand_with_click
      # For now there is no difference to focusing
      focus_with_click
    end
        
    ######################################################################
    # Switch to the tree view tab by clicking on it (e.g. on the 
    # Advanced page of the preferences dialog) 
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the treeitem
    #            is not visible
    #
    def open_tab_with_click
      click
      
      # No event yet so just cheat and sleep
      sleep(0.1);
    end
    
    ######################################################################
    # Double clicks the tree item, and waits for the window with 
    # window name win_name to be shown
    #
    # @param [String] win_name name of the window that will be opened (Pass a blank string for any window)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the treeitem
    #            is not visible
    #
    def open_window_with_double_click(win_name)
      wait_start
      click(:left, 2)
      wait_for_window_shown(win_name)
    end
    
    alias_method :open_dialog_with_double_click, :open_window_with_double_click

private
    # @private
    # Scrolls the item into view if required
    def scroll_item_into_view
      # Make sure we have a window id
      win_id = window_id >= 0 ? window_id : driver.getActiveWindowID()
      
      # Filter only treeitems in parent_treeview
      treeitems = driver.getQuickWidgetList(win_id).select do |wdg|
        wdg.getType == QuickWidget::WIDGET_ENUM_MAP[:treeitem] && wdg.getParentName == parent_name
      end
      
      # Get the first visible item
      lowest = treeitems.find { | item| item.visible? } #This will always be a parent item, not a child
      # Assume list is ordered? => lower row means scroll up, higher row means scroll down
      key = row < lowest.row ? "PageUp" : "PageDown"

      #Select the first item on visible part of list, and select it
      qw = QuickTreeItem.new(self,lowest)
      qw.focus_with_click
      key_press_direct(key)
      
      #First scroll
      key_press_direct(key)
      
      visible_treeitems = driver.getQuickWidgetList(win_id).select do |wdg|
        wdg.getType == QuickWidget::WIDGET_ENUM_MAP[:treeitem] && wdg.getParentName == parent_name && wdg.visible?
      end

      # Stop scrolling if we have run through the whole list, the item is then a child and won't get visible
      max_times = treeitems.length / visible_treeitems.length + 1
      until element(true).visible? || max_times < 0
          key_press_direct(key) 
          max_times-=1
      end
      
    end
  end
  
end

