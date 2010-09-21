module OperaWatir
  class QuickButton < QuickWidget
 
    # Is the specified button the default one. Returns true if is default,
    # otherwise, returns false. 
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    def default?
      element.isDefault
    end
    
    def correct_type?
      @element.getType == "button";
    end
    
  end
end
