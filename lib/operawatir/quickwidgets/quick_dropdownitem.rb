module OperaWatir
  class QuickDropdownItem < QuickEditField #QuickWidget # QuickEditField?

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dropdownitem]
    end
    
    ######################################################################
    # Checks if the item is selected 
    #
    # @return [Boolean] true if the dropdown has the item with the 
    #                   string_id selected, otherwise false
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def selected?
      element(true).isSelected()
    end
    
    ##########################################################################
    #
    #
    #
    def select_with_click
      click
      selected?
    end
    
  end
end 