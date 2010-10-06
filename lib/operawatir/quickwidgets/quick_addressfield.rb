module OperaWatir
  class QuickAddressField < QuickEditField

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:addressfield]
    end
    
  end
end