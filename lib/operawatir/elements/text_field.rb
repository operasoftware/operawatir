module OperaWatir
  class TextField < WebElement

    # Sets the contents of the text field to the provided text.
    # Will overwrite the existing contents.
    #
    # Input:
    # value::  Text to be set.
    #
    # Raises:
    # ObjectDisabledException::  if text field is disabled.
    # ObjectReadOnlyException::  if text field is read only.
    def set(text)
      clear unless value.empty?
      element.sendKeys(text.split(//).to_java(:string))
    end

    # Append the provided text to the contents of the text field.
    #
    # Input:
    # value::  Text to be appended.
    #
    # Raises:
    # ObjectDisabledException::  if text field is disabled.
    # ObjectReadOnlyException::  if text field is read only.
    def append(text)
      set(value + text)
    end
  end
end

