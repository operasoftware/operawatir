module OperaWatir
  class QuickEditField < QuickWidget
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:editfield]
    end
    
    #def set(text)
       #clear unless value.empty?
    #   element.click 1, 0
    #   element.sendKeys(text.split(//).to_java(:string))
    #end
 
  end
end