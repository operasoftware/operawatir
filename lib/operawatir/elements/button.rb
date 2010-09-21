module OperaWatir
  class Button < WebElement
    
    def self.default_method
      :value
    end

    def self.xpath
      "//button | //input[@type = 'button' or @type = 'submit']"
    end

    element_attr_reader :src, :type, :title

    def disabled?
      element.get_attribute :disabled
    end

  end
end
