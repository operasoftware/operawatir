module OperaWatir
  # Class for +input[type=file]+ elements
  class FileField < TextField

    # Sets the value of the file field to a path to a file.
    # @param String path
    def set(path)
      clear unless value.empty?
      element.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end

  private

    def self.xpath
      'input[@type = "file"]'
    end

  end
end

