module OperaWatir::Compat::Elements
  class TextField < WebElement

    def set(text)
      clear unless value.empty?
      element.sendKeys(text.split(//).to_java(:string))
    end

    def append(text)
      set value + text
    end
  end
end

