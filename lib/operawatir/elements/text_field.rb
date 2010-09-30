module OperaWatir
  # Class for +input[type=text], textarea+ elements
  class TextField < WebElement

    # @return [:input] the html tag of the element
    def self.tag
      :input
    end

    def set(text)
      clear unless value.empty?
      element.sendKeys(text.split(//).to_java(:string))
    end

    def append(text)
      set(value + text)
    end

  private

    def self.xpath
      # This is insane, but it's the only way to comply with the spec.
      "//descendant::input[(@type != 'checkbox' and @type != 'radio' and @type != 'submit' and @type != 'image' and @type != 'reset' and @type != 'button' and @type != 'hidden' and @type != 'file') or not(@type)] | //descendant::textarea"
    end

  end


  class FileField < TextField

    def self.tag; :input; end

    def set(path)
      clear unless value.empty?
      element.click 1, 0
      element.sendKeys(path.split(//).to_java(:string))
    end
  end

end
