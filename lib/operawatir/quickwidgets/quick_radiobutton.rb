module OperaWatir
  class QuickRadioButton < QuickCheckbox

    # @private
    # Checks the type of the widget is correct
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:radiobutton]
    end
    
  end
end