module OperaWatir
  class CheckBox < WebElement

    def set(value = true)
      until checked? == value
        element.toggle
      end
    end

    def checked?
      element.isSelected
    end
  end
end

