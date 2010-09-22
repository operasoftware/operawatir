module OperaWatir
  class QuickDropdown < QuickWidget
    
    # Is the entry with the given string_id selected?  Returns true or false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def selected?(string_id)
      element.isSelected(string_id)
    end
    
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:dropdown];
    end
    
    #def select(string_id)
    #  click(1,1)
      #Move mouse to entry
      #click entry
    #end
    #alias_method :set, :select
  end
end 