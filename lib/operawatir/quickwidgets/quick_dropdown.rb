module OperaWatir
  class QuickDropdown < QuickWidget
    
    # Is the specified option (value) selected?  Returns true or false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
    def selected?(text)
      element.text==text
    end
 
  end
end 