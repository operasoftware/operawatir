module OperaWatir
  class FileField < TextField

    def self.xpath
      'input[@type = "file"]'
    end

    def set(path)
      clear unless value.empty?
      element.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end
  end
end

