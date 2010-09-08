module OperaWatir
  class SelectList < WebElement

    def select(value)
      find_option_by_val(value).select!
    end

    alias_method :set, :select
    alias_method :select_value, :select

    def selected?(value)
      find_option_by_val(value).selected?
    end

    def selected_options
      all_options.select {|opt| opt.selected?}
    end

    # def option(method, value)
    #   options.find {|option| option.send(method) == value }
    # end

    def multiple?
      get_attribute 'multiple'
    end

    # Dangerous override.
    def type
      multiple? 'select-multiple' : 'select-one'
    end

    # def value
    #   option :selected?, true
    # end

    def disabled?
      get_attribute 'disabled'
    end

    def includes?(val)
      !!find_option_by_val(val)
    rescue Exceptions::UnknownObjectException
      false
    end

  private

    def find_option_by_val(value)
      options.find {|option| option.value == value } ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :value and #{value.inspect}")
    end

    def find_option_by_text(value)
      options.find {|option| option.text == value || option.label == text} ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :text and #{value.inspect}")
    end
  end

  class Option < WebElement

    def select!
      element.setSelected
    end

    def selected?
      element.isSelected
    end

  end

end

