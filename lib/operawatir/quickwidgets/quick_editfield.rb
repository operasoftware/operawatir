module OperaWatir
  class QuickEditField < QuickWidget
    def correct_type?
      #puts @element.getType
      @element.getType == "multiline_edit"
    end
  end
end