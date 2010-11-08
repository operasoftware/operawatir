module OperaWatir
  class QuickToolbar < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:toolbar]
    end
    
  end
end
