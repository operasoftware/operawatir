module OperaWatir
  class QuickFind < QuickDropdown

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:quickfind]
    end

  end
end
