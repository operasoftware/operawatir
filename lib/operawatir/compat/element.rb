class OperaWatir::Element

  # Gets the attribute called name.
  #
  # @param [String, Symbol] name The name of the attribute to get
  # @return [String] The value of the attribute
  def attr(name)
    node.getAttribute(name.to_s) || ''
  end

  # Check the existence of the attribute on the element.
  #
  # @return [Boolean] true if the attribute exists on the element,
  #   false otherwise
  def attr?(name)
    !node.getAttribute(name.to_s).nil?
  end

  def method_missing(name, *args, &blk)
    if !block_given? && args.empty?
      attr(name)
    else
      super
    end
  end

  # Gets the text content of the element.
  #
  # @return [String] the text content
  def text
    node.getText.strip
  end

  alias_method :to_s, :text

  # On elements of type `<input>` this gets the value of the value
  # attribute, on every other element type it returns the text
  # content.
  #
  # @return [String] value of the element
  def value
    if tag_name == 'INPUT' or attr?(:value)
      attr(:value)
    else
      text
    end
  end

  # Checks whether the text content of the element contains the given
  # string In the compatibility layer as the preferred way of doing
  # this is.
  #
  #   elm.text.should include('My string')
  #
  # @param [String] String to search for
  # @param [Boolean] true if the element's text contains str, false
  #   otherwise
  def verify_contains(str)
    text.include?(str)
  end

  alias_method :verify_contains?, :verify_contains

  alias_method :caption, :text

  # Clicks on the top left of the element, or the given x, y offset.
  #
  # @param [optional, Fixnum] x The offset from the left of the
  #   element
  # @param [optional, Fixnum] y The offset from the top of the element
  def click(x=0, y=0)
    assert_enabled!
    node.click(x.to_i, y.to_i)
  end

  # Focuses the element
  def focus
    trigger! :focus
  end

  alias_method :fire_event, :trigger!

  # Submits a form, or the form the elment is contained in.
  def submit
    assert_exists
    node.submit
  end

  # Clears a text input or textarea of any text.
  def clear
    assert_enabled!
    uncheck!
  end

  # If passed a value it will type text into the element, otherwise it
  # will check a radio button or checkbox.
  #
  # @param [optional, String] value Text to type
  def set(value=nil)
    if value
      self.text = value
    else
      check!
    end
  end

  # Gets the href of an `<a>` element, or the url attribute of any
  # other element.
  #
  # @return [String] an href or the url attribute
  def url
    attr(tag_name == 'A' ? :href : :url)
  end

  # Gets the selected `<option>` elements in a `<select>` element.
  #
  # @return [OperaWatir::Collection] a collection of the selected
  #   `<option>`s
  def selected_options
    options(:selected?, true)
  end

  # On checkboxes, radio buttons, and option elements returns whether
  # the element is checked/selected. On a select element, when passed
  # an value it checks whether the selected option contains the given
  # text.
  #
  # @param [optional, String] value Text the selected option should
  #   contain
  # @return [Boolean] true if the element is selected/selected option
  #   contains value, false otherwise
  def selected?(value=nil)
    if option.nil?
      selected_options.text.include?(value)
    else
      node.isSelected
    end
  end

  alias_method :set?, :checked?

  # For `<select>` elements returns either 'select-one' for
  # `<select>`s where only a single `<option>` can be selected, or
  # 'select-multiple' otherwise.  For non-`<select>` elements returns
  # the `type` attribute.
  def type
    if tag_name == 'SELECT'
      attr(:multiple) == 'multiple' ? 'select-multiple' : 'select-one'
    else
      attr(:type)
    end
  end

  # Gets the colspan attribute as an integer.
  #
  # @return [Fixnum] the colspan
  def colspan
    attr(:colspan).to_i
  end

private

  def assert_enabled!
    raise OperaWatir::Exceptions::ObjectDisabledException if disabled?
  end

end
