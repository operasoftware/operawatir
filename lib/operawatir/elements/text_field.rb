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
      #WTR-117
      #@element.click(1)
      element.sendKeys(*text.to_s.split(//))
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

  class FileField < TextField

    # Sets the path of the file in the textbox.  Path provided must be
    # an absolute path.
    #
    # Input:
    # value::  Absolute path of the file.
    def set(path)
      clear unless value.empty?
      element.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end
  end
end

