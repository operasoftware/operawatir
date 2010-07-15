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
    def set(value)
      clear unless self.to_s.empty?
      #WTR-117
      #@element.click(1)
      @element.sendKeys(value.split('').to_java(:string))
    end

    # Append the provided text to the contents of the text field.
    #
    # Input:
    # value::  Text to be appended.
    #
    # Raises:
    # ObjectDisabledException::  if text field is disabled.
    # ObjectReadOnlyException::  if text field is read only.
    def append(value)
      assert_enabled
      prev_value = self.to_s
      clear
      @element.sendKeys((prev_value << value).split('').to_java(:string))
    end
  end
  
  class FileField < TextField

    # Sets the path of the file in the textbox.  Path provided must be
    # an absolute path.
    #
    # Input: 
    # value::  Absolute path of the file.
    def set(value)
      	clear unless self.to_s.empty?
      	@element.click(1)
      	@element.sendKeys(value.split('').to_java(:string))
    end
  end
end

