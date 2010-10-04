module OperaWatir
  class QuickCheckbox < QuickWidget
    
    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:checkbox];
    end

    ######################################################################
    # Checks if the checkbox is checked
    #
    # @return [Boolean] true if the checkbox is checked otherwise false
    #
    def checked?
      element.isSelected
    end
    
    ######################################################################
    # Clicks a radio button or checkbox and toggles it state
    #
    # @return [int] the new state of the radio button or checkbox,
    #               0 for not checked, or 1 for checked
    #
    def toggle_with_click
      click()
      
      # Cheat since we don't have an even yet 
      sleep(0.1)

      element(true).isSelected
    end
    
  end
end