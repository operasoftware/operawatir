module OperaWatir
  # Class for +button, input[type=submit]+ elements
  class Button < WebElement
    
    # @return [:value]
    def self.default_method
      :value
    end

    element_attr_reader :src, :type, :title

  private

    def self.xpath
      "//descendant::button | //descendant::input[@type = 'button' or @type = 'submit'])"
    end

  end
end
