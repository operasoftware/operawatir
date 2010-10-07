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
    def focus_with_click
      super
    end
        
    ######################################################################
    # Types a text string into the edit field
    #
    # @note Only chanracters that appear on the keyboard that is currently
    #       selected can be typed
    #
    # @param [String] text text string to type in
    # 
    # @return [String] contents of the edit field after typing has completed
    #
    def type_text(text)
      text.each_char { | t | key_press t }
      
      # No event yet so just cheat and sleep
      sleep(0.2);

      # Return what is in the field to check
      element(true).getText
    end

    ######################################################################
    # Clears the contents of the edit field
    #
    def clear
      key_press("a", :ctrl)
      key_press("backspace")
      
      # Cheat until we have an event
      sleep(0.2)
    end
    
  end
end