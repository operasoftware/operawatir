module OperaWatir
  # Class for +select+ elements
  class SelectList < WebElement

    # @return [:select] the html tag of the element
    def self.tag
      :select
    end

    # Options needs to return an array of string values, rather than nodes
    alias_method :option_elements, :options

    # @return  [Array<String>] A list of all the available options
    def options
      element # raises exception if element doesn't exist
      option_elements.map {|opt| opt.label}
    end

    # Finds the element of the child option
    # @param [Symbol] method the property to check
    # @param value the value of the property needed
    # @return [Option]
    def option(method, value)
      option_elements.find {|option| option.send(method) == value}
    end

    # Selects a value
    # @param [String] value the value to select
    def select(value)
      find_option_by_label(value).select!
    end

    alias_method :set, :select
    alias_method :select_value, :select

    # @return [true, false] check wether a value is selected or not
    def selected?(value)
      find_option_by_label(value).selected?
    end

    # @return [Array<String>] the text of the selected options
    def selected_options
      option_elements.select {|opt| opt.selected?}.map {|opt| opt.text}
    end

    # @return [true, false] wether the select box can multiple select
    def multiple?
      get_attribute('multiple') == 'multiple'
    end

    # @return ['select-multiple', 'select-one'] the type of select box.
    # @note This is symantically dangerous override. Breaks polymorphism.
    def type
      multiple? ? 'select-multiple' : 'select-one'
    end

    # @return [true, false] wether the select has an option with the label val
    def includes?(val)
      !!find_option_by_label(val)
    rescue Exceptions::UnknownObjectException
      false
    end

    # @return [String] the current value of the element
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

  # Class for +<option>+ elements
  class Option < WebElement
    # Selects an option
    def select!
      element.setSelected
    end

    # @return [true, false] wether the option is selected
    def selected?
      element.isSelected
    end

    # @return [String] the text label of the option
    def label
      text.strip.length.zero? ? get_attribute('label') : text.strip
    end
  end

end

