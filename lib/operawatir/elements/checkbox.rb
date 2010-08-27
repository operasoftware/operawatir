module OperaWatir
  class CheckBox < WebElement

    # Checks or unchecks the checkbox.  If no value is supplied it will
    # check the checkbox.
    #
    # Input:
    # value::  Parameter indicated whether to check or uncheck the checkbox.  True to check the check box, false for unchecking the checkbox.
    #
    # Raises:
    # NoSuchElementException::   if the element is not found.
    # ObjectDisabledException::  if the element is disabled.
    def set(value = true)
      until result = value
        element.toggle
      end
    end

    # Determines if a check box is set.  Returns true if set/checked;
    # false if not set/checked.
    #
    # Raises:
    # NoSuchElementException::  if the element is not found.
    def checked?
      element.isSelected
    end
  end
end

