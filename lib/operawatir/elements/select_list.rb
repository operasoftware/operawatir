module OperaWatir
  class SelectList < WebElement

    # Selects an item in a select list by its text.  If you need to
    # select multiple items you need to call this function for each
    # item.
    #
    # Input:
    # value::  Text of item to be selected.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def select(value)
      items = element.findElementsByTagName('option')
      find_option_by_text(items, value).setSelected
    end
    alias_method :set, :select

    # Selects an item in a select list by its value.  If you need to
    # select multiple items you need to call this function for each
    # item.
    #
    # Input:
    # value::  Value of the item to be selected.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def select_value(value)
      element.findElementsByTagName('option')
      find_option_by_val(items, value).setSelected
    end

    # Is the specified option (value) selected?  Returns true or false.
    #
    # Raises:
    # NoSuchElementException:  if element is not found.
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

