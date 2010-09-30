module OperaWatir
  class QuickDialogTab < QuickWidget
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dialogtab];
    end
    
    def open_tab_with_click
      click()
      
      # No event yet so just cheat and sleep
      sleep(0.2);
    end
  end  
end
