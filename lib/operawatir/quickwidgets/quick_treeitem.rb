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
    def focus_with_click
      # First scroll the item into view
      scroll_item_into_view
      super
    end
        
    ######################################################################
    # Expands a tree item when it is clicked
    #
    def expand_with_click
      # For now there is no difference to focusing
      focus_with_click
    end
        
    ######################################################################
    # Switch to the tree view tab by clicking on it (e.g. on the 
    # Advanced page of the preferences dialog) 
    #
    def open_tab_with_click
      click()
      
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
      if visible? == false
        lowest = nil
        first = true
        current_loop = 0
        num_list_treeitems = 10000000
      
        # Make sure we have a window id
        win_id = window_id 
        if win_id < 0
          win_id = driver.getActiveWindowID()
        end

        
        while current_loop < num_list_treeitems do
          num_list_treeitems = 0
          driver.getQuickWidgetList(driver.getWindowName(win_id)).map do |java_widget|
            # Only get the tree items that have the parent of this item
            if java_widget.getType == QuickWidget::WIDGET_ENUM_MAP[:treeitem] and
              java_widget.getParentName() == parent_name
               
               # Retain the lowest one for clicking and page down
               if lowest == nil or java_widget.getRow() < lowest.getRow()
                 lowest = java_widget
               end
               
               # Check if we have found it
               if java_widget.getName() == name and java_widget.getText() == text and java_widget.isVisible()
                 # The element is now visible so return and it will be clicked!
                 # Force the element list to be refreshed with what is in view now
                 element(true)
                 return
               end
               
               num_list_treeitems += 1;
            end
          end
          
          # First time select the lowest one and click it
          if first == true
            # Didn't find a visible item so let's scroll!
            qw = QuickTreeItem.new(self,lowest)
            qw.focus_with_click
            key_press("PageDown")
            first = false
          end
          key_press("PageDown")
          current_loop += 1
        end
      end
    end
  end

end

