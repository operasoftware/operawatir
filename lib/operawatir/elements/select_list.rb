module OperaWatir
  class SelectList < WebElement

    def select(value)
      find_option_by_text(items, value).setSelected
    end
    alias_method :set, :select

    def select_value(value)
      element.findElementsByTagName("option")
      find_option_by_val(items, value).setSelected
    end

    def selected?(value)
      element.findElementsByTagName("option")
      find_option_by_val(items, value).isSelected
    end

    def options
      @options ||= element.findElementsByTagName("option")
    end

    def option(method, value)
      options.find {|option| option.send(method) == value }
    end

  private

    def find_option_by_val(items, value)
      options.find {|item| item.getValue == value } ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :value and #{value.inspect}")
    end

    def find_option_by_text(items, value)
      options.find {|item| item.getText == value} ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :text and #{value.inspect}")
    end
  end

  class Option < WebElement
  end

end

