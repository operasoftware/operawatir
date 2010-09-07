module OperaWatir
  class TextField < WebElement

    def set(text)
      clear unless value.empty?
      element.sendKeys(text.split(//).to_java(:string))
    end

    def append(text)
      set(value + text)
    end
  end


  class FileField < TextField
    def set(path)
      clear unless value.empty?
      element.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end
  end

end
