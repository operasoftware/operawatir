module OperaWatir
  class QuickLabel < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:label];
    end
    
  end
end

