module OperaWatir
  class QuickGridLayout < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:gridlayout]
    end

  end
end
