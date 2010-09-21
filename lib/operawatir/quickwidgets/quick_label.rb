module OperaWatir
  class QuickLabel < QuickWidget
    def correct_type?
      @element.getType == "label";
    end
  end
end

