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
    # Select item by click
    #
    # @example
    #    browser.quick_dropdownitem(:text, "Activate the next tab").select_with_click
    #
    # @return true if item is now selected, otherwise false
    #
    def select_with_click
      if mac_internal?
        press_menu
      else
        click
      end
      selected?
    end

    private

    # Selects an item from a drop down pop menu where you can't click them on Mac
    def press_menu
      driver.pressQuickMenuItem(text, true);
    end
  end
end