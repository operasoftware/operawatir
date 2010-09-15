module OperaWatir
  module DesktopContainer
    
    # Method for accessing a button element
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A Button object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_button(how, what)
      QuickButton.new(self, how, what)
    end

    # Method for accessing a checkbox
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A QuickCheckbox object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_checkbox(how, what)
      QuickCheckbox.new(self, how, what)
    end

    # Method for accessing a Dialog tab
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A QuickDialogTab object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_dialogtab(how, what)
      QuickDialogTab.new(self, how, what)
    end

    # Method for accessing a button element, typically a <button> or <input type="submit" /> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A Button object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_dropdown(how, what)
      QuickDropdown.new(self, how, what)
    end

    
    # Method for accessing an EditField
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A QuickEditField object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_editfield(how, what)
      QuickEditField.new(self, how, what)
    end

    # Method for accessing a Label, 
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A QuickLabel object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_label(how,what)
      QuickLabel.new(self,how,what)
    end

    # Method for accessing a radiobutton element
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    #
    # Returns:
    # A QuickRadioButton object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def quick_radiobutton(how, what)
      QuickRadioButton.new(self, how, what)
    end
  end
end

