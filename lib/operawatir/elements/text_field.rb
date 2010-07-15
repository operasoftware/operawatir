module OperaWatir
  class TextField < WebElement
    def set(value)
      clear unless self.to_s.empty?
      #WTR-117
      #@element.click(1)
      @element.sendKeys(value.split('').to_java(:string))
    end

    def append(value)
      assert_enabled
      prev_value = self.to_s
      clear
      @element.sendKeys((prev_value << value).split('').to_java(:string))
    end
  end
  
  class FileField < TextField
    def set(value)
      	clear unless self.to_s.empty?
      	@element.click(1)
      	@element.sendKeys(value.split('').to_java(:string))
    end
  end
  
end
