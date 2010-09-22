module OperaWatir
  class QuickLabel < QuickWidget
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:label];
    end
  end
end

