module OperaWatir
  class QuickEditField < QuickWidget
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:editfield]
    end

    public :focus_with_click
        
    #def set(text)
       #clear unless value.empty?
    #   element.click 1, 0
    #   element.sendKeys(text.split(//).to_java(:string))
    #end

    # Return the text of the widget
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def type_text(text)
      text.each_char { | t | key_press t }
      
      # No event yet so just cheat and sleep
      sleep(0.2);

      # Return what is in the field to check
      element.getText
    end

    #
    # Raises:
    # NoSuchElementException::  if element is is not found.
    def clear
      key_press("a", :ctrl)
      key_press("backspace")
      
      # Cheat until we have an event
      sleep(0.1)
    end
    
  end
end