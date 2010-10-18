module OperaWatir::Compat::Elements
  class Button < WebElement

    element_attr_reader :src, :type, :title

    def disabled?
      element.get_attribute :disabled
    end

  end
end

