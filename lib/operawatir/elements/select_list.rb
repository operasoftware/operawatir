module OperaWatir
  class SelectList < WebElement

    def select(value)
      find_option_by_val(value).setSelected
    end

    alias_method :set, :select
    alias_method :select_value, :select

    def selected?(value)
      find_option_by_val(value).isSelected
    end

    def options
      @options ||= element.findElementsByTagName("option")
    end

    def option(method, value)
      options.find {|option| option.send(method) == value }
    end

  private

    def find_option_by_val(value)
      options.find {|option| option.getValue == value } ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :value and #{value.inspect}")
    end

    def find_option_by_text(value)
      options.find {|option| option.getText == value} ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :text and #{value.inspect}")
    end
  end

  class Option < WebElement
  end

end

