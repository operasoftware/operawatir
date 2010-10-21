module OperaWatir
  class QuickEditField < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:editfield]
    end

    ######################################################################
    # Set focus to the edit field by clicking on it
    #
    # @raise [DesktopExceptions::WidgetNotVisibleException] if the editfield 
    #            is not visible
    #
    def focus_with_click
      super
    end
        
    ######################################################################
    # Types a text string into the edit field
    #
    # @note Only chanracters that appear on the keyboard that is currently
    #       selected can be typed, and the edit field must have focus.
    #
    # @param [String] text text string to type in
    # 
    # @return [String] contents of the edit field after typing has completed
    #
    def type_text(text)
      text.each_char { | t | key_press_direct t }
      
      # No event yet so just cheat and sleep
      sleep(0.2);

      # Return what is in the field to check
      element(true).getText
    end

    ######################################################################
    # Clears the contents of the edit field
    #
    # @note The edit field must have focus for this method to work
    #
    def clear
      key_press_direct("a", :ctrl)
      key_press_direct("backspace")
      
      # Cheat until we have an event
      sleep(0.1)
    end

    ######################################################################
    # Presses a key inclding modifiers
    #
    # @example
    #   $browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("a", :ctrl)
    #   $browser.quick_toolbar(:name, "Document Toolbar").quick_addressfield(:name, "tba_address_field").key_press("c", :ctrl)
    #
    # @param [String]  key         key to press (e.g. "a" or "backspace")
    # @param [Symbol]  modifiers   optional modifier(s) to hold down while pressing the key (e.g. :shift, :ctrl, :alt, :meta)
    #
    # @return [String] Text in the field after the keypress
    #
    # @note The edit field must have focus for this method to work
    # @note WARNING: This method will not wait for page load or window
    #       shown events. If you need to wait for these events do not
    #       use this method
    #
    def key_press(key, *modifiers)
      key_press_direct(key, *modifiers)
      
      # Cheat until we have an event
      sleep(0.1)

      # Return what is in the field to check
      element(true).getText
    end

    private  
    # @private
    # Presses the key, and waits for loading to finish
    def load_page_with_key_press(key, *modifiers)
      wait_start
      key_press_direct(key, *modifiers)
      wait_for_window_loaded("")
    end

    # @private
    # Enter some text and hit enter to do the action for the field
    def enter_text_and_hit_enter(text)
      loaded_url = ""
      
      # Set focus
      focus_with_click
      # Clear the field
      clear()
      # Type in the text
      typed_text = type_text(text) #Opens dropdown window
      # Check that some text was typed, note the text might be changed in the
      # url field so it might be different
      if typed_text.length > 0
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