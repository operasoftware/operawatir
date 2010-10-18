module OperaWatir::Compat::Elements::Checkbox < WebElement

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

