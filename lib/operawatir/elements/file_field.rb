module OperaWatir
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

