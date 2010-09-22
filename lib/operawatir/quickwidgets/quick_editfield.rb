module OperaWatir
  class QuickEditField < QuickWidget
    def correct_type?
      #puts @element.getType
      @element.getType == "multiline_edit" || @element.getType == "edit"
    end
    
    #def set(text)
       #clear unless value.empty?
    #   element.click 1, 0
    #   element.sendKeys(text.split(//).to_java(:string))
    #end
 
  end
end