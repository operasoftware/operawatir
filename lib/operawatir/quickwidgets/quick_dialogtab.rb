module OperaWatir
  class QuickDialogTab < QuickWidget
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dialogtab];
    end
  end  
end
