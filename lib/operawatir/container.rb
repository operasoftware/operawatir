module OperaWatir
  module Container

    # Method for accessing a text field of various types.  Usually an
    # <input type="text" /> HTML tag or a <textarea> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A TextField object.
    #
    # Usage:
    #
    #   @browser.text_field(:id,   "user_name")                      # access the text field with an ID of user_name
    #   @browser.text_field(:name, "address")                        # access the text field with a name of address
    #   @browser.text_field(:index, 2)                               # access the second text field on the page (1 based, so the first field is accessed with :index, 1)
    #   @browser.text_field(:xpath, "//textarea[@id='user_name']/")  # access the text field with an ID of user_name
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def text_field(how,what)
      return TextField.new(self,how,what)
    end

    # Method for accessing a form element, typically a <form> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A Form object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.    
    def form(how,what)
      return Form.new(self,how,what)
    end

    # Method for accessing a button element, typically a <button> or <input type="submit" /> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    # * value
    # * class
    #
    # Returns:
    # A Button object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.    
    def button(how,what=nil)
      if what.nil?
        return Button.new(self,:value,how)
      end
      return Button.new(self,how,what)
    end

    # Method for accessing a link element, typically an <a href=""> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    # * text
    # * href
    # * index
    #
    # Returns:
    # A Link object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.    
    def link(how,what)
      return Link.new(self, how,what)
    end

    # Method for accessing a select list element, typically a <select> tag.
    #
    # Arguments:
    # how::   (Symbol.)  Selector for how we are to locate the element.
    # what::  (String.)  (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A SelectList object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def select_list(how, what=nil)
      return SelectList.new(self, how, what)
    end

    # Method for accessing a checkbox element, typically a <input type="checkbox" /> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    # value::  (Optional.)  When there are multiple objects with different value attributes, this can be used to find the correct object.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    # * value
    #
    # Returns:
    # A CheckBox object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def checkbox(how, what=nil, value=nil)
      return CheckBox.new(self, how, what, value)
    end

    # Method for accessing a radio element.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    # value::  (Optional.)  When there are multiple objects with different value attributes, this can be used to find the correct object.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    # * value
    #
    # Returns:
    # A Radio object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def radio(how, what=nil, value=nil)
      return Radio.new(self, how, what, value)
    end

    # Method for accessing an area element, typically an <area>foobar</area> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # An Area object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def area(how,what)
      return Area.new(self,how,what)
    end

    # Method for accessing an image element, typically a <img src="foo.png" alt="" /> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # An Image object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def image(how,what)
      return Image.new(self,how,what)
    end

    # Method for accessing a div element, typically a <div> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A Div object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def div(how,what)
      return Div.new(self,how,what)
    end

    # Method for accessing a p (paragraph) element, typically a <p> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A P object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def p(how,what)
      return P.new(self,how,what)
    end
    
    # Method for accessing a generic element.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name
    # * id
    # * index
    # * xpath
    # * selector
    #
    # Returns:
    # A generic object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def element(how,what)
      return Element.new(self,how,what)
    end

    # Method for accessing a hidden element, typically a <input type="hidden" />.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name 
    # * id 
    # * index
    # * xpath
    # * selector 
    #
    # Returns:
    # A Hidden object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def hidden(how,what)
      return Hidden.new(self,how,what)
    end

    # Method for accessing a file field element, typically a <input type="file" />.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name 
    # * id
    # * index 
    # * xpath
    # * selector 
    #
    # Returns:
    # A FileField object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def file_field(how,what)
      return FileField.new(self,how,what)
    end

    # Method for accessing an unordered list element, typically a <ul> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name 
    # * id
    # * index 
    # * xpath
    # * selector 
    #
    # Returns:
    # An Ul object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def ul(how,what)
      return Ul.new(self,how,what)
    end

    # Method for accessing a span element, typically a <span> tag.
    #
    # Arguments:
    # how::    Selector symbol for how we are to locate the element.
    # what::   (Optional.)  Integer, string or regular expression; depending on which selector you are using.
    #
    # Selectors (for <tt>:how</tt>):
    # * name 
    # * id
    # * index 
    # * xpath
    # * selector 
    #
    # Returns:
    # An Span object.
    #
    # Raises:
    # NoSuchElementException::  if element is not found.
    def span(how,what)
      return Span.new(self,how,what)
    end
  end
end

