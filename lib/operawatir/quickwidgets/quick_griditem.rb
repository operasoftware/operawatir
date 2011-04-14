module OperaWatir
  class QuickGridItem < QuickWidget

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:griditem]
    end

  end
end
