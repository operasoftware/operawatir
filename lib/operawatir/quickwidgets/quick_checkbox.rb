module OperaWatir
  class QuickCheckbox < QuickWidget
    
    # Determines if a check box is set.  Returns true if set/checked;
    # false if not set/checked.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def checked?
      element.isSelected
    end
    
    def correct_type?
      @element.getType == WIDGET_ENUM_MAP[:checkbox];
    end
    
  end
end