module OperaWatir
  class SelectList < WebElement

    def select(value)
      items = element.findElementsByTagName('option')
      find_option_by_text(items, value).setSelected
    end
    alias_method :set, :select

    def select_value(value)
      element.findElementsByTagName('option')
      find_option_by_val(items, value).setSelected
    end

    def selected?(value)
      element.findElementsByTagName('option')
      find_option_by_val(items, value).isSelected
    end

  private

    def find_option_by_val(items, value)
      items.find {|item| item.getValue == value } || raise("Can't find option by value : #{value}")
    end

    def find_option_by_text(items, value)
      items.find {|item| item.getText == value} || raise("Can't find option by value : #{value}")
    end
  end
end

