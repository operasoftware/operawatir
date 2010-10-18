module OperaWatir::Compat::Elements
  class CheckBox < WebElement

    def set(value = true)
      until checked? == value
        element.toggle
      end
    end

    def set?
      element.isSelected
    end
    alias_method :checked?, :set?

  end
end

