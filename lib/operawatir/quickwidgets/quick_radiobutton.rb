module OperaWatir
  class QuickRadioButton < QuickCheckbox
    def correct_type?
      @element.getType == "radiobutton"
    end
  end
end