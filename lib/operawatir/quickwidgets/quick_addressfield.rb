module OperaWatir
  class QuickAddressField < QuickEditField

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:addressfield]
    end

    ######################################################################
    # Presses the key, and waits for loading to finish
    #
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [String]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [int] Window ID of the window shown or 0 if no window is shown
    #
    def load_page_with_key_press(key, *modifiers)
      wait_start
      key_press(key, *modifiers)
      wait_for_window_loaded("")
    end
    
    ######################################################################
    # Enters the url into the addres field, and waits for loading to finish
    #
    # @param [String] url   Web Address to load
    #
    # @return [String] text in the address field after the page is loaded
    #                   or a blank string
    #
    def load_page_with_url(url)
      loaded_url = ""
      
      # Set focus
      focus_with_click()
      # Clear the field
      clear()
      # Type in the url
      typed_text = type_text(url)
      
      # Check that the typing matched what was expected
      if typed_text == url
        # Hit Enter to load the typed in url
        win_id = load_page_with_key_press("Enter")
        
        # Check that the page actually loaded in a window
        if win_id > 0
          # Refresh the control and get the text after the page as loaded
          loaded_url = element(true).getText
        end
      end
      
      loaded_url
    end
    
  end
end