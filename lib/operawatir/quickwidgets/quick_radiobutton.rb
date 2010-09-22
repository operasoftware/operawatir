module OperaWatir
  class QuickRadioButton < QuickCheckbox
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:radiobutton]
    end
  end
end