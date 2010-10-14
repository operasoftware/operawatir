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
    
  end
end

