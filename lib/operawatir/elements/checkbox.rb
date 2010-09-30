module OperaWatir
  # Class for +input[type=checkbox]+ elements
  class CheckBox < WebElement

    # Sets the checkbox's value
    # @param [true, false] value
    def set(value = true)
      until checked? == value
        toggle
      end
    end

    # Toggles the checkbox
    def toggle
      element.toggle
    end

    # @return [true, false] the checkbox is selected
    def set?
      element.isSelected
    end

    alias_method :checked?, :set?

  end
end

