module OperaWatir
  class SelectList < WebElement
    
    def select(value)
      assert_exists
      items = @element.findElementsByTagName('option')
      find_option_by_text(items, value).setSelected
    end
    alias_method :set, :select

    def select_value(value)
      assert_exists
      items = @element.findElementsByTagName('option')
      find_option_by_val(items, value).setSelected
    end

    def selected? value
      assert_exists
      items = @element.findElementsByTagName('option')
      find_option_by_val(items, value).isSelected
    end

    def find_option_by_val(items, value)
      items.each do |item|
        return item if item.getValue.eql?(value)
      end
      raise "Can't find option by value : #{value}"
    end
    private(:find_option_by_val)

    def find_option_by_text(items, value)
      items.each do |item|
        return item if item.getText.eql?(value)
      end
      raise "Can't find option by value : #{value}"
    end
    private(:find_option_by_text)

  end
end