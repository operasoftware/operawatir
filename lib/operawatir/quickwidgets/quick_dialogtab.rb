module OperaWatir
  class QuickDialogTab < QuickWidget
    def correct_type?
      @element.getType == "group";
    end
  end  
end
