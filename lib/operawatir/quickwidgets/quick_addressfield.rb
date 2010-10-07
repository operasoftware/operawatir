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
      click()
      wait_for_window_loaded("")
    end
    
  end
end