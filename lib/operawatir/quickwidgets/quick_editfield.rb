module OperaWatir
  class QuickEditField < QuickWidget
    def correct_type?
      @element.getType == "edit"
    end
  end
end