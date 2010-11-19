module OperaWatir
  class QuickDropdown < QuickEditField #QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dropdown]
    end
    
    ######################################################################
    # Checks if the item selected in the dropdown matches the text loaded
    # from Opera using the string_id
    #
    # @param [String] string_id String ID to use to load the string from the current
    #                 language file (e.g. "D_NEW_PREFERENCES_GENERAL")
    #
    # @return [Boolean] true if the dropdown has the item with the 
    #                   string_id selected, otherwise false
    #
    # @raise [Exceptions::UnknownObjectException] if the widget could not be found
    #           using the specified method
    def selected?(string_id)
      element.isSelected(string_id)
    end
    
  end
end 