module OperaWatir
  class SelectList < WebElement

    def self.tag
      :select
    end

    # Options needs to return an array of string values, rather than nodes
    alias_method :option_elements, :options

    def options
      element # raises exception if element doesn't exist
      option_elements.map {|opt| opt.label}
    end

    def option(method, value)
      option_elements.select {|option| option.send(method) == value}
    end

    def select(value)
      find_option_by_label(value).select!
    end

    alias_method :set, :select
    alias_method :select_value, :select

    def selected?(value)
      find_option_by_label(value).selected?
    end

    def selected_options
      option_elements.select {|opt| opt.selected?}.map {|opt| opt.text}
    end
    
    def multiple?
      get_attribute('multiple') == 'multiple'
    end

    # Dangerous override.
    def type
      multiple? ? 'select-multiple' : 'select-one'
    end

    def disabled?
      get_attribute('disabled') == 'true'
    end

    def includes?(val)
      !!find_option_by_label(val)
    rescue Exceptions::UnknownObjectException
      false
    end

    # TODO There is no way to set an attribute, or set the selected attribute.
    def clear
      element
    end

    def value
      option_elements.select {|opt| opt.selected?}.map {|opt| opt.value}.last
    end

  private

    def find_option_by_val(value)
      option_elements.find {|option| option.value.match(value) } ||
        raise(Exceptions::UnknownObjectException,
              "Unable to locate Option, using :value and #{value.inspect}")
    end

    def find_option_by_label(value)
      option_elements.find {|option| option.label.match(value)} ||
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

    def label
      text.strip.length.zero? ? get_attribute('label') : text.strip
    end

  end

end

